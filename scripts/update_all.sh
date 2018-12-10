#!/bin/bash

echo "replicating cockroach binaries, and etc config to all nodes"

hosts="roach2 roach3 roach4 roach5"
for h in $hosts
do
	rsync -avv -e "ssh -T" /opt/etc root@$h:/
	rsync -avv --progress -e "ssh -T" /opt/cockroach root@$h:/opt/
	rsync -avv -e "ssh -T" --delete /opt/scripts root@$h:/opt/
	ssh root@$h "chmod +x /opt/cockroach"
done

