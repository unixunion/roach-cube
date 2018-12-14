#!/bin/bash

echo "replicating cockroach binaries, and etc config to all nodes"

hosts="roach1 roach2 roach3 roach4 roach5"
for h in $hosts
do
	rsync -avv -e "ssh -T" /opt/etc root@$h:/
	if [ "$h" != "$HOSTNAME" ]; then 
		rsync -avv -e "ssh -T" --delete /opt/etc root@$h:/opt/
		rsync -avv -f '- */*'  --progress -e "ssh -T" /opt/ root@$h:/opt/
		rsync -avv -e "ssh -T" --delete /opt/scripts root@$h:/opt/
	fi
	ssh root@$h "chmod +x /opt/cockroach"
done

