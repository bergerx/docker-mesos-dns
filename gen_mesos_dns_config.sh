#!/bin/bash

# Generate Mesos-DNS config from environment variables
# For example running:
# > env \
# >   MESOS_DNS_ZK=zk://10.101.160.15:2181/mesos \
# >   MESOS_DNS_MASTERS=10.101.160.15:5050,10.101.160.16:5050,10.101.160.17:5050 \
# >   MESOS_DNS_RESOLVERS=169.254.169.254 \
# >   MESOS_DNS_REFRESHSECONDS=10 \
# >   MESOS_DNS_HTTPON=false \
# >   ./gen_mesos_dns_config.sh
# will produce:
# {
#   "zk": "zk://10.101.160.15:2181/mesos",
#   "masters": ["10.101.160.15:5050", "10.101.160.16:5050", "10.101.160.17:5050"],
#   "refreshSeconds": 10,
#   "resolvers": ["169.254.169.254"],
#   "httpon": false
# }

function add {
  local name=$1
  local vtype=$2

  # Use all uppercase MESOS_DNS_{config_key} environment variables
  local env_name="MESOS_DNS_${name^^}"
  local env_val=${!env_name}

  # Don't do anything if environment varibale is not found
  [ -z "$env_val" ] && return

  local val
  if [ $vtype == "str" ]; then
    # put given value inside double quotes(`"`)
    val="\"$env_val\""
  elif [ $vtype == "int" -o $vtype == "bool" ]; then
    val="$env_val"
  elif [ $vtype == "list" ]; then
    # turn `a,b,c` into `["a", "b", "c"]`
    val="[\"${env_val//,/\", \"}\"]"
  fi

  echo "  \"$name\": ${val},"
}

function add_all {
  add zk             str
  add masters        list
  add refreshSeconds int
  add ttl            int
  add domain         str
  add port           int
  add resolvers      list
  add timeout        int
  add httpon         bool
  add dsnon          bool
  add httpport       int
  add externalon     bool
  add listener       str
  add SOAMname       str
  add SOARname       str
  add SOARefresh     int
  add SOARetry       int
  add SOAExpire      int
  add SOAMinttl      int
  add IPSources      list
  add recurseon      bool
  add enforceRFC952  bool
}
echo "{"
# We have to get rid of trailing ',' in last item for not breaking JSON
add_all | sed '$s/,$//'
echo "}"
