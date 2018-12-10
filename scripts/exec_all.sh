#!/bin/bash

hosts="roach1 roach2 roach3 roach4 roach5"
for h in $hosts
do
	echo "---==== $h ====---"
	ssh -tt root@$h $@
done

