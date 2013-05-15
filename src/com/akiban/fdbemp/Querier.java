
package com.akiban.fdbemp;

import org.yaml.snakeyaml.Yaml;
import com.foundationdb.Database;
import com.foundationdb.FDB;
import com.foundationdb.Retryable;
import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;
import java.lang.reflect.Constructor;
import java.util.*;
import java.io.*;

public class Querier implements Retryable
{
    private Operator operator;
    private boolean output;

    public static void main(String[] args) throws Throwable {
        int repeat = 0;
        if (args.length > 1) {
            repeat = Integer.parseInt(args[1]);
        }
        new Querier("data.yaml", args[0]).run(repeat);
    }

    @SuppressWarnings("unchecked")
    public Querier(String file, String query) throws Exception {
        Map<String,Object> data;
        try (InputStream istr = new FileInputStream("data.yaml")) {
            Yaml yaml = new Yaml();
            data = (Map<String,Object>)yaml.load(istr);
        }
        List<String> trees = (List<String>)data.get("trees");
        Map<String,Map<String,Object>> queries = (Map<String,Map<String,Object>>)data.get("queries");
        operator = parseOperator(queries.get(query), trees);
    }

    public void run(int repeat) throws Throwable {
        FDB fdb = FDB.selectAPIVersion(21);
        Database db = fdb.open().get();

        output = true;
        db.run(this);
        
        if (repeat > 0) {
            output = false;
            long startTime = System.currentTimeMillis();
            for (int i = 0; i < repeat; i++) {
                db.run(this);
            }
            long endTime = System.currentTimeMillis();
            System.out.println((double)(endTime - startTime) / repeat + " ms.");
        }

        fdb.dispose();
    }

    @Override
    public void attempt(Transaction tr) throws Exception {
        operator.open(tr);
        while (true) {
            Tuple row = operator.next();
            if (row == null) break;
            if (output) {
                System.out.println(row.getItems());
            }
        }
    }

    @SuppressWarnings("unchecked")
    protected Operator parseOperator(Map<String,Object> options, List<String> trees)
            throws Exception {
        Operator input = null;
        Map<String,Object> inputOptions = (Map<String,Object>)options.get("input");
        if (inputOptions != null) {
            input = parseOperator(inputOptions, trees);
        }
        Class clazz = Class.forName("com.akiban.fdbemp." + options.get("operator") + "Operator");
        Constructor ctor = clazz.getConstructor(Map.class, Operator.class, List.class);
        return (Operator)ctor.newInstance(options, input, trees);
    }

}
