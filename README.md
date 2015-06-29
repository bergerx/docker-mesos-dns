# mesos-dns

This is a fork of [3h4x/docker-mesos-dns](https://github.com/3h4x/docker-mesos-dns) to allow all configs to be given as environment variables.

## quick start

```
MESOS_DNS=$(docker run -it \
  -e MESOS_DNS_ZK=zk://10.101.160.15:2181/mesos \
  -e MESOS_DNS_MASTERS=10.101.160.15:5050,10.101.160.16:5050,10.101.160.17:5050 \
  -e MESOS_DNS_RESOLVERS=8.8.8.8 \
  -p 53:53/udp \
  bergerx/mesos-dns)
```

check if all is good with

`docker logs $MESOS_DNS`

## test it

Try to resolve mesos leader:

`dig +short @$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" $MESOS_DNS) leader.mesos`

if it returns IP then all is good!

## Environment varibales:

Every mesos config variable has a corresponding environment variable, prepended with `MESOS_DNS_` and all uppercase config key , some examples:
* `zk` config key will be given as `MESOS_DNS_ZK`,
* `masters` config key will be given as `MESOS_DNS_MASTERS` and should be given as a comma seperated list,
* `ttl` config key will be given as `MESOS_DNS_TTL`

## Fork:

## Docs:
[mesos-dns](http://mesosphere.github.io/mesos-dns/docs/naming.html)
