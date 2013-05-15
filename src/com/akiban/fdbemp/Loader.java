
package com.akiban.fdbemp;

import org.yaml.snakeyaml.Yaml;
import com.foundationdb.Database;
import com.foundationdb.FDB;
import com.foundationdb.Retryable;
import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;
import java.util.*;
import java.io.*;

public class Loader
{
    private List<LoadFile> loadFiles;

    public static void main(String[] args) throws Throwable {
        new Loader("data.yaml").load();
    }

    @SuppressWarnings("unchecked")
    public Loader(String file) throws IOException {
        Map<String,Object> data;
        try (InputStream istr = new FileInputStream("data.yaml")) {
            Yaml yaml = new Yaml();
            data = (Map<String,Object>)yaml.load(istr);
        }
        List<String> trees = (List<String>)data.get("trees");

        Map<String,Object> files = (Map<String,Object>)data.get("files");
        loadFiles = new ArrayList<>(files.size());
        for (String tableName : files.keySet()) {
            Map<String,Object> options = (Map<String,Object>)files.get(tableName);
            LoadFile loadFile = new LoadFile(tableName);
            loadFile.parseOptions(options, trees, loadFiles);
            loadFiles.add(loadFile);
        }
    }

    public void load() throws Throwable {
        FDB fdb = FDB.selectAPIVersion(21);
        Database db = fdb.open().get();

        db.run(new Retryable() {
                @Override
                public void attempt(Transaction tr) throws Exception {
                    tr.clear(EMPTY, new byte[] { (byte)0xFF });
                }
            });

        for (LoadFile loadFile : loadFiles) {
            load(loadFile, db);
        }
        
        fdb.dispose();
    }

    static final byte[] EMPTY = new byte[0];
    static final int COMMIT_COUNT = 100000;
    static final boolean RETRY = true;

    protected static class PendingSets implements Retryable {
        private int count, limit;
        private byte[][] pending;

        public PendingSets(int limit) {
            this.limit = limit;
            pending = new byte[(limit+100)*2][];
        }

        public void empty() {
            count = 0;
        }

        public void add(byte[] key, byte[] value) {
            pending[count*2] = key;
            pending[count*2+1] = value;
            count++;
        }

        public boolean full() {
            return (count >= limit);
        }

        @Override
        public void attempt(Transaction tr) throws Exception {
            for (int i = 0; i < count; i++) {
                tr.set(pending[i*2], pending[i*2+1]);
            }
        }
    }

    protected void load(LoadFile loadFile, Database db) throws Throwable {
        System.out.println("Loading " + loadFile.getName());
        try (FileReader r = new FileReader(loadFile.getFile())) {
            BufferedReader br = new BufferedReader(r);
            br.readLine();      // Header row.
            PendingSets pending = new PendingSets(COMMIT_COUNT);
            while (true) {
                String line = br.readLine();
                if (line != null) {
                    Object[] row = loadFile.parseRow(line);
                    Tuple hkey = Tuple.from(loadFile.hkey(row));
                    Tuple value = Tuple.from(row);
                    pending.add(hkey.pack(), value.pack());
                    for (LoadFile.Index index : loadFile.getIndexes()) {
                        Tuple key = Tuple.from(index.build(row));
                        pending.add(key.pack(), EMPTY);
                    }
                }
                if ((line == null) || pending.full()) {
                    if (RETRY) {
                        db.run(pending);
                    }
                    else {
                        Transaction tr = db.createTransaction();
                        pending.attempt(tr);
                        tr.commit().get();
                    }
                    pending.empty();
                }
                if (line == null) break;
            }
        }
    }

}
