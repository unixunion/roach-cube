#!/bin/bash

#ntpd -s
#hwclock -w

/opt/scripts/exec_all_notme.sh "/etc/init.d/ntp stop; killall ntpclient; /etc/init.d/ntp start"

#echo roach1: `date`
#
#hosts="roach2 roach3 roach4 roach5"
#for h in $hosts
#do
#	echo -en "$h: "
#	ssh root@$h "/etc/init.d/ntp restart"
#done
