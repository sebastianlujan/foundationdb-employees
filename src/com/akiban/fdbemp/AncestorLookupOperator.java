
package com.akiban.fdbemp;

import com.foundationdb.tuple.Tuple;
import java.util.*;

public class AncestorLookupOperator extends Operator
{
    private int[][] ancestors;
    private Tuple inputTuple;
    private int inputIndex;

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
    }

    @Override
    public Tuple next() {
        while (true) {
            if (inputTuple == null) {
                inputTuple = input.next();
                if (inputTuple == null) {
                    return null;
                }
                inputIndex = 0;
            }
            while (inputIndex < ancestors.length) {
                int[] ancestor = ancestors[inputIndex++];
                Iterator<Object> items = inputTuple.iterator();
                int n = ancestor[0];
                while (n-- > 0) {
                    items.next();
                }
                List<Object> hkey = new ArrayList<>();
                for (int i = 1; i < ancestor.length; i+=2) {
                    hkey.add(ancestor[i]); // Tree index or Path ordinal
                    n = ancestor[i+1];
                    while (n-- > 0) {
                        hkey.add(items.next());
                    }
                }
                byte[] row = transaction.get(Tuple.fromList(hkey).pack()).get();
                if (row != null) {
                    return Tuple.fromBytes(row);
                }
            }
            inputTuple = null;
        }
    }
}
