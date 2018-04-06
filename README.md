## Description ##
CloudLab profile for running RAMCloud with DPDK enabled on the CloudLab Utah
m510 machines.

## Instructions ##
To test that everything is working, run the following command from the RAMCloud
directory:

```
./scripts/clusterperf.py -r 0 --transport=basic+dpdk --dpdkPort 1 --verbose --superuser echo_basic
```

Which should have the following output:

```
Coordinator started on rc05-ctrl at basic+udp:host=128.110.153.110,port=12246
Coordinator command line arguments  /shome/jde/RAMCloud/obj.master/coordinator -C basic+udp:host=128.110.153.110,port=12246 -l NOTICE --logFile logs/20180406105753/coordinator.rc05-ctrl.log  --dpdkPort 1
Server started on rc01-ctrl at basic+dpdk::  /shome/jde/RAMCloud/obj.master/server -C basic+udp:host=128.110.153.110,port=12246 -L basic+dpdk: -r 0 -l NOTICE --clusterName __unnamed__ --logFile logs/20180406105753/server1.rc01-ctrl.log --preferredIndex 1 -t 4000 --dpdkPort 1  -f /local/rcbackup/backup.log
ensureServers command:  /shome/jde/RAMCloud/obj.master/apps/ensureServers -C basic+udp:host=128.110.153.110,port=12246 -m 1 -b 1 -l 1 --wait 30 --logFile logs/20180406105753/ensureServers.log
All servers running
Client 0 started on rc02-ctrl:  /shome/jde/RAMCloud/obj.master/apps/ClusterPerf -C basic+udp:host=128.110.153.110,port=12246 --numClients 1 --clientIndex 0 --logFile logs/20180406105753/client1.rc02-ctrl.log --seconds 10 --maxSessions 1 --size 100 echo_basic --dpdkPort 1
epvnkmsf finished
echo0                  4.5 us     send 0B message, receive 0B message median
echo0.min              4.4 us     send 0B message, receive 0B message minimum
echo0.9                4.9 us     send 0B message, receive 0B message 90%
echo0.99               5.6 us     send 0B message, receive 0B message 99%
echo0.999            123.4 us     send 0B message, receive 0B message 99.9%
echoBw0                0.0 B/s    bandwidth sending 0B messages
echo100                4.8 us     send 100B message, receive 100B message median
echo100.min            4.7 us     send 100B message, receive 100B message minimum
echo100.9              4.9 us     send 100B message, receive 100B message 90%
echo100.99             5.3 us     send 100B message, receive 100B message 99%
echo100.999          235.6 us     send 100B message, receive 100B message 99.9%
echoBw100             17.9 MB/s   bandwidth sending 100B messages
echo1K                 6.6 us     send 1000B message, receive 1KB message median
echo1K.min             6.5 us     send 1000B message, receive 1KB message minimum
echo1K.9               6.8 us     send 1000B message, receive 1KB message 90%
echo1K.99              7.2 us     send 1000B message, receive 1KB message 99%
echo1K.999           127.0 us     send 1000B message, receive 1KB message 99.9%
echoBw1K             136.6 MB/s   bandwidth sending 1KB messages
echo10K               14.8 us     send 10000B message, receive 10KB message median
echo10K.min           14.6 us     send 10000B message, receive 10KB message minimum
echo10K.9             14.9 us     send 10000B message, receive 10KB message 90%
echo10K.99            15.3 us     send 10000B message, receive 10KB message 99%
echo10K.999          129.9 us     send 10000B message, receive 10KB message 99.9%
echoBw10K            626.0 MB/s   bandwidth sending 10KB messages
echo100K              91.2 us     send 100000B message, receive 100KB message median
echo100K.min          91.0 us     send 100000B message, receive 100KB message minimum
echo100K.9            91.5 us     send 100000B message, receive 100KB message 90%
echo100K.99          101.8 us     send 100000B message, receive 100KB message 99%
echo100K.999         215.8 us     send 100000B message, receive 100KB message 99.9%
echoBw100K             1.0 GB/s   bandwidth sending 100KB messages
echo1M               859.8 us     send 1000000B message, receive 1MB message median
echo1M.min           859.5 us     send 1000000B message, receive 1MB message minimum
echo1M.9             864.4 us     send 1000000B message, receive 1MB message 90%
echo1M.99            980.1 us     send 1000000B message, receive 1MB message 99%
echo1M.999             1.2 ms     send 1000000B message, receive 1MB message 99.9%
echoBw1M               1.1 GB/s   bandwidth sending 1MB messages
```
