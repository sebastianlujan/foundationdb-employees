
package com.akiban.fdbemp;

import com.foundationdb.Transaction;
import com.foundationdb.tuple.Tuple;

public abstract class Operator
{
    protected Transaction transaction;
    protected Operator input;

    protected Operator(Operator input) {
        this.input = input;
    }

    public void open(Transaction tr) throws Exception {
        transaction = tr;
        input.open(tr);
    }

    public abstract Tuple next();
}
