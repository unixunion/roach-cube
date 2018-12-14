#!/bin/bash

#ntpd -s
#hwclock -w

/opt/scripts/exec_all_notme.sh "/etc/init.d/ntpd stop; killall ntpd; ntpclient -s -i 5 -c 5 roach5; /etc/init.d/ntpd start"

