#!/bin/sh

# logging stdout/stderr
set -x
exec >> /root/cluster-postcreate-cdsw-gpu.log 2>&1
date

CM_USERNAME=admin
CM_PASSWORD=admin
CLUSTER_NAME=SingleNodeCluster

DEPLOYMENT_HOST=`hostname -f`
DEPLOYMENT_PORT=7180
DEPLOYMENT_HOST_PORT="${DEPLOYMENT_HOST}:${DEPLOYMENT_PORT}"

## GPU settings on CDSW
# Config item "cdsw.nvidia.lib.path.config" is removed from CDSW1.6
#NVIDIA_LIBRARY_PATH="/var/lib/nvidia-docker/volumes/nvidia_driver/${NVIDIA_DRIVER_VERSION}"
CDSW_SERVICE_NAME=$(curl -s -u ${CM_USERNAME}:${CM_PASSWORD} http://${DEPLOYMENT_HOST_PORT}/api/v19/clusters/${CLUSTER_NAME}/services |  jq -r '.items[] | select( .type == "CDSW") | .name')
#curl -X PUT -H "Content-Type:application/json" -u ${CM_USERNAME}:${CM_PASSWORD} -d '{ "items": [ { "name": "cdsw.nvidia.lib.path.config", "value": "'${NVIDIA_LIBRARY_PATH}'" }] }' http://${DEPLOYMENT_HOST_PORT}/api/v19/clusters/${CLUSTER_NAME}/services/${CDSW_SERVICE_NAME}/config
curl -X PUT -H "Content-Type:application/json" -u ${CM_USERNAME}:${CM_PASSWORD} -d '{ "items": [ { "name": "cdsw.enable.gpu.config", "value": "true" }] }' http://${DEPLOYMENT_HOST_PORT}/api/v19/clusters/${CLUSTER_NAME}/services/${CDSW_SERVICE_NAME}/config

curl -X POST -u ${CM_USERNAME}:${CM_PASSWORD} http://${DEPLOYMENT_HOST_PORT}/api/v19/clusters/${CLUSTER_NAME}/services/${CDSW_SERVICE_NAME}/commands/restart
sleep 10
