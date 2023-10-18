#!/bin/bash

# Selectivly copy directories from the latest commit of the main gl-repo
# Not copying the whole directory because not all features are needed in this repo

TEMP_DIR=$(mktemp -d)
curl -fsSL https://github.com/gardenlinux/gardenlinux/archive/refs/heads/main.zip --output $TEMP_DIR/gl.zip
unzip $TEMP_DIR/gl.zip -d $TEMP_DIR
cp -r $TEMP_DIR/gardenlinux-main/bin/* gardenlinux/bin/
cp -r $TEMP_DIR/gardenlinux-main/cert/* gardenlinux/cert/
cp -r $TEMP_DIR/gardenlinux-main/container/* gardenlinux/container/
cp -r $TEMP_DIR/gardenlinux-main/features/_boot/* gardenlinux/features/_boot/
cp -r $TEMP_DIR/gardenlinux-main/features/_curl/* gardenlinux/features/_curl/
cp -r $TEMP_DIR/gardenlinux-main/features/_dev/* gardenlinux/features/_dev/
cp -r $TEMP_DIR/gardenlinux-main/features/_ignite/* gardenlinux/features/_ignite/
cp -r $TEMP_DIR/gardenlinux-main/features/_slim/* gardenlinux/features/_slim/
cp -r $TEMP_DIR/gardenlinux-main/features/aws/* gardenlinux/features/aws/
cp -r $TEMP_DIR/gardenlinux-main/features/azure/* gardenlinux/features/azure/
cp -r $TEMP_DIR/gardenlinux-main/features/base/* gardenlinux/features/base/
cp -r $TEMP_DIR/gardenlinux-main/features/cloud/* gardenlinux/features/cloud/
cp -r $TEMP_DIR/gardenlinux-main/features/firewall/* gardenlinux/features/firewall/
cp -r $TEMP_DIR/gardenlinux-main/features/gcp/* gardenlinux/features/gcp/
cp -r $TEMP_DIR/gardenlinux-main/features/kvm/* gardenlinux/features/kvm/
cp -r $TEMP_DIR/gardenlinux-main/features/log/* gardenlinux/features/log/
cp -r $TEMP_DIR/gardenlinux-main/features/metal/* gardenlinux/features/metal/
cp -r $TEMP_DIR/gardenlinux-main/features/openstack/* gardenlinux/features/openstack/
cp -r $TEMP_DIR/gardenlinux-main/features/server/* gardenlinux/features/server/
cp -r $TEMP_DIR/gardenlinux-main/features/ssh/* gardenlinux/features/ssh/
cp -r $TEMP_DIR/gardenlinux-main/features/vmware/* gardenlinux/features/vmware/
cp $TEMP_DIR/gardenlinux-main/build gardenlinux/build

