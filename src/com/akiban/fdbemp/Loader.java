
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

    protected void load(LoadFile loadFile, Database db) throws Throwable {
        System.out.println("Loading " + loadFile.getName());
        try (FileReader r = new FileReader(loadFile.getFile())) {
            BufferedReader br = new BufferedReader(r);
            br.readLine();      // Header row.
            final byte[][] pending = new byte[(COMMIT_COUNT+100)*2][];
            int count = 0;
            while (true) {
                String line = br.readLine();
                if (line != null) {
                    Object[] row = loadFile.parseRow(line);
                    Tuple hkey = Tuple.from(loadFile.hkey(row));
                    Tuple value = Tuple.from(row);
                    pending[count*2] = hkey.pack();
                    pending[count*2+1] = value.pack();
                    count++;
                    for (LoadFile.Index index : loadFile.getIndexes()) {
                        Tuple key = Tuple.from(index.build(row));
                        pending[count*2] = key.pack();
                        pending[count*2+1] = EMPTY;
                        count++;
                    }
                }
                if ((line == null) || (count > COMMIT_COUNT)) {
                    final int todo = count*2;
                    db.run(new Retryable() {
                            @Override
                            public void attempt(Transaction tr) throws Exception {
                                for (int i = 0; i < todo; i+=2) {
                                    tr.set(pending[i], pending[i+1]);
                                }
                            }
                        });
                    count = 0;
                }
                if (line == null) break;
            }
        }
    }

}
