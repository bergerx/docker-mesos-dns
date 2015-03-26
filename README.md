# mesos-dns

quick start

`MESOS_DNS=$(docker run -it -e MESOS_IP=_YOUR_MESOS_MASTER_IP_ -p 53:53/udp 3h4x/mesos-dns)`

check if all is good with

`docker logs $MESOS_DNS`

configure your resolv.conf to match new nameserver on docker and test it

`ping leader.mesos`


docs:
[mesos-dns](http://mesosphere.github.io/mesos-dns/docs/naming.html)