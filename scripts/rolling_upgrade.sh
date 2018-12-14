#!/bin/bash

set -e
echo
echo "this script will perform a rolling, graceful upgrade of the entire cluster, including this node."
echo "prior to running this script, you should have placed a new binary in /opt e.g /opt/cockroach-1.2.3.4,"
echo "and created a symlink from /opt/cockroach to /opt/cockroach-1.2.3.4, this script will then sync out the "
echo "symlink and binary during the upgrade process"
echo
read -p "Press enter to proceed" -n 1 -r

hosts="roach1 roach2 roach3 roach4 roach5"

for h in $hosts
do
	echo "----===== $h =====----"
	echo "----------------------------"

	# query cluster for reported running version of the node in question
	running_version=`/opt/cockroach node status --host $h --insecure | grep "$h:" | awk '{print $3;}'`

	# check the local "future" symlinked binary version on this node
	new_version=`/opt/cockroach version |head -n 1 |awk '{print $3;}'`

	# only update if -ne
	if [ "$running_version" = "$new_version" ]; then
		echo "running_version: " $running_version
		echo "new_version:" $new_version
		echo "node: $h is already on the same binary"
	else
		echo "upgrading node: $h"
		echo "running_version: " $running_version
		echo "new_version:" $new_version
		echo
		echo "upgrade commences in 5 seconds..."
		sleep 5

		echo "decommission node"
		ssh root@$h "/opt/cockroach quit --decommission --host $h --insecure; /etc/init.d/crdb stop"

		# we dont need to redistribute cockroach SYMLINK to "this" node...
		if [ "$h" != "$HOSTNAME" ]; then
			echo "syncing symlink and binaries"
			rsync -avv  --progress -e "ssh -T" /opt/cockroach root@$h:/opt/
		fi	

		echo "starting crdb"
		ssh root@$h "/etc/init.d/crdb start"

		echo "sleeping 15 seconds"
		sleep 15;

		echo "recomission the node"
		ssh root@$h "/opt/cockroach node recommission `/opt/cockroach node status  --insecure --host=$h |grep \"$h:\" | awk '{print $1;}'` --host $h --insecure"
	fi
done


