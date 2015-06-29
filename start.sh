#!/bin/bash
/gen_mesos_dns_config.sh > /config.json
exec /go/src/mesos-dns/mesos-dns -config /config.json "$@"
