#!/bin/sh

# logging stdout/stderr
set -x
exec >> /root/bootstrap.log 2>&1
date

./setup_krb.sh aws templates/iot_workshop.json /dev/xvdf

./scripts/instance-postcreate-gpu-p2-instance.sh
