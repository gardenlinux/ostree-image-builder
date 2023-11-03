#!/usr/bin/env bash

# Demo for a workflow where the image gets a new package
# We'll build two OSTree commits, one with the default package list, one with zsh added
# When booting the image, you'll have the first commit which does not include zsh
# Once you upgraded to the latest commit, you'll have zsh available

set -eufo pipefail

set -x

HOST_IP=$(hostname -i | awk '{print $3}')
echo "http://${HOST_IP}:9090" > features/ostreeRepo/CONFIG_REMOTE_URL

ARCH=$(dpkg --print-architecture)

echo "Downloading published repo as a starting point."
wget --output-document features/ostreeRepo/ostree-debian-repo-${ARCH}.tar.gz http://ostree.gardenlinux.io/ostree-debian-repo-${ARCH}.tar.gz

rm -rf .build

echo "Building new repo with first commit"
./build ostreeRepo

REPO=$(find . -name 'ostreeRepo*trixie*.ostreeRepo.tar.gz')
cp $REPO features/ostreeImage/ostree-debian-repo-${ARCH}.tar.gz
cp $REPO features/ostreeRepo/ostree-debian-repo-${ARCH}.tar.gz

echo "Building bootable image containing the first commit."
./build ostreeImage
rm -rf .build/ostreeRepo*

echo "Building new repo with second commit that includes zsh."
echo zsh >> features/ostreeRepo/pkg.include
./build ostreeRepo

mkdir -p .build/repo/debian-repo-${ARCH}
tar xzvf $REPO -C .build/repo/debian-repo-${ARCH}
pushd .build/repo/
echo "Serving repo locally so our vm image can be upgraded."
python3 -m http.server 9090 &
popd

ostree log --repo=.build/repo/debian-repo-${ARCH} debian/testing/${ARCH} | head -n14

echo "Reverting change which added zsh package"
git checkout features/ostreeRepo/pkg.include

echo "Done building the demo workflow."
echo "Next steps: Start the virtual machine, verify the booted system has no zsh available, perform an upgrade, reboot, and verify zsh is available now."

SERVER_PID=$(ps aux | grep "python3 -m http.server 9090" | head -n1 | awk '{print $2}')
echo "PID of the local web server serving the local OSTree repo: $SERVER_PID"
