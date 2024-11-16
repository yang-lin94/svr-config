#!/bin/bash
clear
echo "Welcome to Alpine Linux : `cat /etc/alpine-release`"

# default shell
export SHELL='/bin/bash'

# network interface
export GW=$(ip route | awk '/default/ {print $3}')
export GWIF=$(ip route | awk '/default/ {print $5}')
export IP=$(ip a show "${GWIF}" | awk '/inet / {print $2}' | cut -d'/' -f1)

if [ "${IP}" != "" ]; then
  echo "
${GWIF} IP: ${IP}/${NETMASK}
${GWIF} GW: ${GW}
"
fi

