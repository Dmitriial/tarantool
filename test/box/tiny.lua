#!/usr/bin/env tarantool
os = require('os')

box.cfg{
    listen              = os.getenv("LISTEN"),
    memtx_memory    =  50 * 1024 * 1024,
    pid_file            = "tarantool.pid",
    force_recovery  = false,
    slab_alloc_factor = 1.1,
    rows_per_wal        = 5000000
}

require('console').listen(os.getenv('ADMIN'))
box.once('init', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')
end)
