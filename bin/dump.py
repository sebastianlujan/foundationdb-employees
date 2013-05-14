#!/usr/bin/env python

import fdb
import fdb.tuple

fdb.api_version(21)
db = fdb.open()

@fdb.transactional
def dump_tuples(tr, start, end):
    for k,v in tr[:]:
        print fdb.tuple.unpack(k), fdb.tuple.unpack(v)

dump_tuples(db, '', '\xFF')

