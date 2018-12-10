#!/bin/bash

hosts="roach1 roach2 roach3 roach4 roach5"
for h in $hosts 
do
	scp ~/.ssh/id_rsa.pub root@$h:~/.ssh/authorized_keys
	scp ~/.ssh/id_rsa.pub root@$h:~/.ssh/
	scp ~/.ssh/id_rsa root@$h:~/.ssh/
done

