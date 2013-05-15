
package com.akiban.fdbemp;

import com.foundationdb.Transaction;
import com.foundationdb.KeyValue;
import com.foundationdb.tuple.ArrayUtil;
import com.foundationdb.tuple.Tuple;
import java.util.*;

public class IndexScanOperator extends Operator
{
    private byte[] beginBytes, endBytes;
    private Iterator<KeyValue> iterator;

    public IndexScanOperator(Map<String,String> options, Operator input, 
                             List<String> trees) {
        super(input);
        assert(input == null);

        String indexName = options.get("index");
        int treeIndex = trees.indexOf(indexName)+1;
        if (treeIndex <= 0) {
            throw new IllegalArgumentException("index not found " + indexName);
        }
        Tuple beginTuple = Tuple.from(treeIndex);
        Tuple endTuple = Tuple.from(treeIndex+1);
        Object option;
        option = options.get("eq");
        if (option != null) {
            Tuple tuple = beginTuple.addObject(option);
            beginBytes = tuple.pack();
            endBytes = ArrayUtil.strinc(beginBytes);
        }
        option = options.get("ge");
        if (option != null) {
            Tuple tuple = beginTuple.addObject(option);
            beginBytes = tuple.pack();
        }
        option = options.get("gt");
        if (option != null) {
            Tuple tuple = beginTuple.addObject(option);
            beginBytes = tuple.pack();
            beginBytes = ArrayUtil.strinc(beginBytes);
        }
        option = options.get("lt");
        if (option != null) {
            Tuple tuple = beginTuple.addObject(option);
            endBytes = tuple.pack();
        }
        option = options.get("le");
        if (option != null) {
            Tuple tuple = beginTuple.addObject(option);
            endBytes = tuple.pack();
            endBytes = ArrayUtil.strinc(endBytes);
        }
        if (beginBytes == null) {
            beginBytes = beginTuple.pack();
        }
        if (endBytes == null) {
            endBytes = endTuple.pack();
        }
    }

    @Override
    public void open(Transaction tr) throws Exception {
        iterator = tr.getRange(beginBytes, endBytes).iterator();
    }

    @Override
    public Tuple next() {
        if (!iterator.hasNext()) {
            return null;
        }
        return Tuple.fromBytes(iterator.next().getKey());
    }
}
