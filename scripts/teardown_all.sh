#!/bin/bash

read -p "Are you sure you want to DELETE all cockroach-data? y/N" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  /opt/scripts/exec_all.sh killall -9 cockroach
  /opt/scripts/exec_all.sh rm -rf /opt/cockroach-data
fi
