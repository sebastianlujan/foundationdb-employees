
package com.akiban.fdbemp;

import org.yaml.snakeyaml.Yaml;
import com.foundationdb.Database;
import com.foundationdb.FDB;
import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;
import java.util.*;
import java.io.*;

public class Loader
{
    private List<LoadFile> loadFiles;

    public static void main(String[] args) throws Exception {
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

    public void load() throws Exception {
        FDB fdb = FDB.selectAPIVersion(21);
        Database db = fdb.open().get();
        Transaction tr = db.createTransaction();

        tr.clear(EMPTY, new byte[] { (byte)0xFF });
        tr.commit().get();

        for (LoadFile loadFile : loadFiles) {
            load(loadFile, tr);
            tr.commit().get();
        }
        
        fdb.dispose();
    }

    static final byte[] EMPTY = new byte[0];
    static final int COMMIT_COUNT = 100000;

    protected void load(LoadFile loadFile, Transaction tr) throws IOException {
        System.out.println("Loading " + loadFile.getName());
        try (FileReader r = new FileReader(loadFile.getFile())) {
            BufferedReader br = new BufferedReader(r);
            br.readLine();      // Header row.
            int pending = 0;
            while (true) {
                String line = br.readLine();
                if (line == null) break;
                Object[] row = loadFile.parseRow(line);
                Tuple hkey = Tuple.from(loadFile.hkey(row));
                Tuple value = Tuple.from(row);
                tr.set(hkey.pack(), value.pack());
                pending++;
                for (LoadFile.Index index : loadFile.getIndexes()) {
                    Tuple key = Tuple.from(index.build(row));
                    tr.set(key.pack(), EMPTY);
                    pending++;
                }
                if (pending > COMMIT_COUNT) {
                    tr.commit().get();
                    pending = 0;
                }
            }
        }
    }

}
