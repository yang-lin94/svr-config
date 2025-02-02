#!/bin/bash
clear
echo "Welcome to Alpine Linux : `cat /etc/alpine-release`"

# default shell
export SHELL='/bin/bash'

# network interface
export GW
GW=$(ip route | awk '/default/ {print $3}')

export GWIF
GWIF=$(ip route | awk '/default/ {print $5}')

export IP
IP=$(ip a show "${GWIF}" | awk '/inet / {print $2}' | cut -d'/' -f1)

export MAC
MAC=$(ip a show "${GWIF}" | awk '/ether/ {print $2}')

export NETMASK
NETMASK=$(ip a show "${GWIF}" | awk '/inet / {print $2}' | cut -d'/' -f2)

if [ "${IP}" != "" ]; then
  echo "
${GWIF} IP: ${IP}/${NETMASK}
${GWIF} GW: ${GW}
"
fi

