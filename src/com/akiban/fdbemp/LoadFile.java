
package com.akiban.fdbemp;

import java.util.*;
import java.io.*;

public class LoadFile
{
    private String name;
    private File file;
    private List<String> columns;
    private BitSet numericColumns;
    private LoadFile parent;
    private List<LoadFile> children;
    private int[] hkeyComponents;
    private List<Index> indexes;

    public static class Index {
        private int treeIndex;
        private int[] offsets;

        public Index(int treeIndex, int[] offsets) {
            this.treeIndex = treeIndex;
            this.offsets = offsets;
        }

        public Object[] build(Object[] row) {
            Object[] irow = new Object[offsets.length+1];
            irow[0] = treeIndex;
            for (int i = 0; i < offsets.length; i++) {
                irow[i+1] = row[offsets[i]];
            }
            return irow;
        }
    }

    public LoadFile(String name) {
        this.name = name;
    }

    @SuppressWarnings("unchecked")
    public void parseOptions(Map<String,Object> options, 
                             List<String> trees, List<LoadFile> extent) {
        file = new File((String)options.get("file"));
        columns = (List<String>)options.get("columns");
        List<String> types = (List<String>)options.get("types");
        assert (columns.size() == types.size());
        numericColumns = new BitSet(types.size());
        for (int i = 0; i < types.size(); i++) {
            if (types.get(i).equals("integer")) {
                numericColumns.set(i);
            }
        }
        String parentName = (String)options.get("parent");
        found:
        if (parentName != null) {
            for (LoadFile existing : extent) {
                if (existing.getName().equals(parentName)) {
                    parent = existing;
                    if (parent.children == null)
                        parent.children = new ArrayList<>();
                    parent.children.add(this);
                    break found;
                }
            }
            throw new IllegalArgumentException("parent " + parent + 
                                               " not found for " + name);
        }
        List<String> keys = (List<String>)options.get("keys");
        int nkeys = keys.size() + 1;
        if (parent != null) {
            nkeys++;
        }
        hkeyComponents = new int[nkeys];
        {
            int i = 0, j = 0;
            if (parent != null) {
                hkeyComponents[i++] = parent.hkeyComponents[0];
                while (j + 1 < parent.hkeyComponents.length) {
                    String sharedKey = keys.get(j++);
                    int idx = columns.indexOf(sharedKey);
                    if (idx < 0) {
                        throw new IllegalArgumentException("key column " + sharedKey +
                                                           " not found for " + name);
                    }
                    hkeyComponents[i++] = idx;
                }
                hkeyComponents[i++] = - parent.children.size(); // child ordinal
            }
            else {
                int treeIndex = trees.indexOf(name);
                if (treeIndex < 0) {
                    throw new IllegalArgumentException("tree not found for root table " + name);
                }
                hkeyComponents[0] = - treeIndex;
            }
            while (j + 1 < keys.size()) {
                String key = keys.get(j++);
                int idx = columns.indexOf(key);
                if (idx < 0) {
                    throw new IllegalArgumentException("key column " + key +
                                                       " not found for " + name);
                }
                hkeyComponents[i++] = idx;
            }
            assert (i == hkeyComponents.length);
        }
        Map<String,List<String>> indexOptions = (Map<String,List<String>>)options.get("indexes");
        if (indexOptions != null) {
            indexes = new ArrayList<>(indexOptions.size());
            for (String indexName : indexOptions.keySet()) {
                int treeIndex = trees.indexOf(indexName);
                if (treeIndex < 0) {
                    throw new IllegalArgumentException("tree not found for index " + indexName);
                }
                List<String> indexKeys = new ArrayList<>(indexOptions.get(indexName));
                indexKeys.addAll(keys);
                int[] offsets = new int[indexKeys.size()];
                for (int i = 0; i < offsets.length; i++) {
                    String indexKey = indexKeys.get(i);
                    int offset = columns.indexOf(indexKey);
                    if (offset < 0) {
                        throw new IllegalArgumentException("index column " + indexKey +
                                                           " not found for " + name);
                    }
                    offsets[i] = offset;
                }
                indexes.add(new Index(treeIndex, offsets));
            }
        }
        else {
            indexes = Collections.emptyList();
        }
    }

    public String getName() {
        return name;
    }

    public File getFile() {
        return file;
    }

    public List<Index> getIndexes() {
        return indexes;
    }

    public Object[] parseRow(String line) {
        Object[] row = new Object[columns.size()];
        int i = 0, idx = 0;
        while (i < row.length) {
            int nidx = line.indexOf(',', idx);
            if (nidx < 0) {
                if (i != row.length - 1) {
                    throw new IllegalArgumentException("not enough columns");
                }
                nidx = line.length();
            }
            else {
                if (i == row.length - 1) {
                    throw new IllegalArgumentException("too many columns");
                }
            }
            String col = line.substring(idx, nidx);
            Object val;
            if (col.equals("")) {
                val = null;
            }
            else if (numericColumns.get(i)) {
                val = Long.valueOf(col);
            }
            else {
                val = col;
            }
            row[i++] = val;
            idx = nidx + 1;
        }
        return row;
    }

    public Object[] hkey(Object[] row) {
        Object[] hkey = new Object[hkeyComponents.length];
        for (int i = 0; i < hkeyComponents.length; i++) {
            if (hkeyComponents[i] < 0) {
                hkey[i] = Long.valueOf(- hkeyComponents[i]);
            }
            else {
                hkey[i] = row[hkeyComponents[i]];
            }
        }
        return hkey;
    }
}
