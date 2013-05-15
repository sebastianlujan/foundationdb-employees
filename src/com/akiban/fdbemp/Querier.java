
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
    Operator operator;

    public static void main(String[] args) throws Throwable {
        new Querier("data.yaml", args[0]).run();
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

    public void run() throws Throwable {
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
            System.out.println(row.getItems());
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
