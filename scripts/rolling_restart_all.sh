#!/bin/bash

/opt/scripts/exec_all.sh "/opt/cockroach quit; /etc/init.d/crdb stop; /etc/init.d/crdb start"

