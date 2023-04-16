#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi



docker-compose down

ovs-vsctl del-br sw0
ovs-vsctl del-br sw1

route delete default

dhclient


