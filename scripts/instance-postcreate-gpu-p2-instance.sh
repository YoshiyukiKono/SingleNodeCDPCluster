#!/bin/bash

THIS_FILE_NAME=$(basename $0 .sh)

# logging stdout/stderr
set -x
exec >> /root/$THIS_FILE_NAME.log 2>&1
date

# Settings for GPU
## Installing some tools
yum groupinstall -y "Development tools"
curl -OL http://ftp.riken.jp/Linux/cern/centos/7/updates/x86_64/Packages/kernel-devel-3.10.0-693.5.2.el7.x86_64.rpm
yum install -y kernel-devel-3.10.0-693.5.2.el7.x86_64.rpm

## Installing NVIDIA Driver
#NVIDIA K80 GPU
#https://www.nvidia.co.jp/Download/driverResults.aspx/155532/jp
#https://www.nvidia.com/Download/driverResults.aspx/155291/en-us
#NVIDIA_DRIVER_VERSION="418.116.00"
NVIDIA_DRIVER_VERSION="418.116.00"
curl -OL http://us.download.nvidia.com/tesla/${NVIDIA_DRIVER_VERSION}/NVIDIA-Linux-x86_64-${NVIDIA_DRIVER_VERSION}.run
chmod 755 NVIDIA-Linux-x86_64-${NVIDIA_DRIVER_VERSION}.run
./NVIDIA-Linux-x86_64-${NVIDIA_DRIVER_VERSION}.run -asq

nvidia-smi

#https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/optimize_gpu.html
nvidia-persistenced
nvidia-smi --auto-boost-default=0
nvidia-smi -ac 2505,875
