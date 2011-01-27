#!/bin/bash
# A simple script to update the host name to be "ip-abc-def-uvw-xyz" where the IP address
# of the machine is abc.def.uvw.xyz

IP_ADDR=`/sbin/ifconfig eth0 | grep 'inet addr' | gawk -F: '{print $2}' | gawk '{print $1}'`
HOSTNAME=ip-`echo $IP_ADDR|sed -e 's/\./-/g'`
hostname $HOSTNAME
echo "$IP_ADDR  $HOSTNAME" >> /etc/hosts
