#!/bin/bash

octat2=`ifconfig | grep -E "eth0\b" -A1 | grep inet | cut -d: -f2 | cut -d' ' -f1 | cut -d'.' -f2`
octat3=1
octat4=1
for counter in `seq 1 4000`
do
	echo >> /etc/network/interfaces
	echo "auto eth0:$counter" >> /etc/network/interfaces
	echo "iface eth0:$counter inet static" >> /etc/network/interfaces
	echo "address 172.$octat2.$octat3.$octat4" >> /etc/network/interfaces
	echo "netmask 255.0.0.0" >> /etc/network/interfaces
	if [ $octat4 -eq 255 ]
	then
		octat4=0
		octat3=$((octat3+1))
	else
		octat4=$((octat4+1))
	fi	
done





#edit /proc/sys/net/core/netdev_max_backlog to contain more than 1000 (tcp packet queue)
#edit /proc/sys/net/core/somaxconn to something larger than 128
#default number of allowed ssh connections per network is 10 for ssh. configure sshd_conf to contain "MaxSessions" larger than 10.
#default "MaxStartups" (unauthenticated connections to ssh) is 10. configure to be larger.
