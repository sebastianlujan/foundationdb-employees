
package com.akiban.fdbemp;

import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;

public abstract class Operator
{
    public abstract void open(Transaction tr) throws Exception;
    public abstract Tuple next();
}
