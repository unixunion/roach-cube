#!/bin/bash

read -p "Are you sure you want to POWERDOWN all nodes? y/N" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	/opt/scripts/exec_all_notme.sh halt
fi

