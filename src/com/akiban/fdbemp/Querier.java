
package com.akiban.fdbemp;

import org.yaml.snakeyaml.Yaml;
import com.foundationdb.Database;
import com.foundationdb.FDB;
import com.foundationdb.Retryable;
import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;
import java.util.*;
import java.io.*;

public class Querier implements Retryable
{
    Operator operator;

    public static void main(String[] args) throws Exception {
        new Querier("data.yaml", args[0]).run();
    }

    @SuppressWarnings("unchecked")
    public Querier(String file, String query) throws IOException {
        Map<String,Object> data;
        try (InputStream istr = new FileInputStream("data.yaml")) {
            Yaml yaml = new Yaml();
            data = (Map<String,Object>)yaml.load(istr);
        }
        List<String> trees = (List<String>)data.get("trees");
        Map<String,Map<String,String>> queries = (Map<String,Map<String,String>>)data.get("queries");
        operator = parseOperator(queries.get(query));
    }

    public void run() throws Exception {
        FDB fdb = FDB.selectAPIVersion(21);
        Database db = fdb.open().get();

        db.run(this);
        
        fdb.dispose();
    }

    @Override
    public void attempt(Transaction tr) throws Exception {
        operator.open(tr);
        while (true) {
            Tuple row = operator.next();
            if (row == null) break;
            System.out.println(row);
        }
    }

    protected Operator parseOperator(Map<String,String> options) throws Exception {
        Class<Operator> clazz = Class.forName("com.akiban.fdbemp." + options.get("operaator"));
        Constructor<Operator> ctor = clazz.getConstructor(java.util.Map.class);
        return ctor.newInstance(options);
    }

}
