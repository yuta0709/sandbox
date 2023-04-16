#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

NIC=eth0

/usr/share/openvswitch/scripts/ovs-ctl --system-id=random start

bash stop.sh

docker-compose up -d

ovs-docker add-port sw0 eth0 router --ipaddress=10.0.10.1/24
ovs-docker add-port sw1 eth1 router --ipaddress=10.0.20.1/24

ovs-docker add-port sw0 eth0 bind-c2 --ipaddress=10.0.10.10/24 --gateway=10.0.10.1
ovs-docker add-port sw0 eth0 c2 --ipaddress=10.0.10.20/24 --gateway=10.0.10.1

ifconfig ${NIC} 0.0.0.0

ovs-vsctl add-port sw1 ${NIC}

route delete default