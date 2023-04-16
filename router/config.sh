#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

set interfaces ethernet eth0 address 10.0.10.1/24
set interfaces ethernet eth1 address 10.0.20.1/24
set protocols ospf area 0 network 10.0.10.0/24
set protocols ospf area 0 network 10.0.20.0/24
set protocols ospf parameters router-id 1.1.1.1

commit
save

