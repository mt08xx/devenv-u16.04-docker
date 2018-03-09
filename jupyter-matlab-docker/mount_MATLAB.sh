#!/bin/bash 

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
MATLAB_ISO_DIR=/vagrant
MATLAB_RELEASE=R2017b
MATLAB_ROOT=/opt/MATLAB/${MATLAB_RELEASE}
mkdir -p ${MATLAB_ROOT}{,_help,_toolbox}_org
mount -o loop,ro ${MATLAB_ISO_DIR}/${MATLAB_RELEASE}.iso ${MATLAB_ROOT}_org
mount -o loop,ro ${MATLAB_ISO_DIR}/${MATLAB_RELEASE}_help.iso ${MATLAB_ROOT}_help_org
mount -o loop,ro ${MATLAB_ISO_DIR}/${MATLAB_RELEASE}_toolbox.iso ${MATLAB_ROOT}_toolbox_org
#
for i in ${MATLAB_ROOT}{,_help,_toolbox}
do
    OVERLAY_DIR=$i
    mkdir -p ${OVERLAY_DIR}_rw/{upper,work} ${OVERLAY_DIR}
    mount -t overlay -o lowerdir=${OVERLAY_DIR}_org,upperdir=${OVERLAY_DIR}_rw/upper,workdir=${OVERLAY_DIR}_rw/work overlay ${OVERLAY_DIR}
done


export PATH="${MATLAB_ROOT}/bin":$PATH

