#!/bin/sh

# logging stdout/stderr
set -x
exec >> /root/bootstrap.log 2>&1
date

./scripts/instance-postcreate-gpu-p2-instance.sh

./setup_krb.sh aws templates/iot_workshop.json /dev/xvdf

./scripts/cluster-postcreate-cdsw-gpu.sh 
