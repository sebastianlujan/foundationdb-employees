
package com.akiban.fdbemp;

import com.foundationdb.AsyncFuture;
import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;
import java.util.*;

public class AncestorLookupOperator extends Operator
{
    private int[][] ancestors;
    private AsyncFuture<byte[]>[] futures;
    private int futureIndex;

    @SuppressWarnings("unchecked")
    public AncestorLookupOperator(Map<String,Object> options, Operator input, 
                                  List<String> trees) {
        super(input);

        String groupName = (String)options.get("group");
        int treeIndex = trees.indexOf(groupName)+1;
        if (treeIndex <= 0) {
            throw new IllegalArgumentException("group not found " + groupName);
        }
        List<List<Integer>> ancestorsOption = (List<List<Integer>>)options.get("ancestors");
        ancestors = new int[ancestorsOption.size()][];
        for (int i = 0; i < ancestors.length; i++) {
            List<Integer> ancestorOption = ancestorsOption.get(i);
            int[] ancestor = new int[ancestorOption.size()+1];
            ancestor[0] = ancestorOption.get(0);
            ancestor[1] = treeIndex;
            for (int j = 2; j < ancestor.length; j++) {
                ancestor[j] = ancestorOption.get(j-1);
            }
            ancestors[i] = ancestor;
        }
        futures = (AsyncFuture<byte[]>[])new AsyncFuture[ancestors.length];
    }

    @Override
    public void open(Transaction tr) throws Exception {
        super.open(tr);
        futureIndex = futures.length;
    }
    
    @Override
    public Tuple next() {
        while (true) {
            if (futureIndex < futures.length) {
                byte[] row = futures[futureIndex++].get();
                if (row != null) {
                    return Tuple.fromBytes(row);
                }
            }
            Tuple inputTuple = input.next();
            if (inputTuple == null) {
                return null;
            }
            for (int i = 0; i < ancestors.length; i++) {
                int[] ancestor = ancestors[i];
                Iterator<Object> items = inputTuple.iterator();
                int n = ancestor[0];
                while (n-- > 0) {
                    items.next();
                }
                List<Object> hkey = new ArrayList<>();
                for (int j = 1; j < ancestor.length; j+=2) {
                    hkey.add(ancestor[j]); // Tree index or Path ordinal
                    n = ancestor[j+1];
                    while (n-- > 0) {
                        hkey.add(items.next());
                    }
                }
                futures[i] = transaction.get(Tuple.fromList(hkey).pack());
            }
            futureIndex = 0;
        }
    }
}
