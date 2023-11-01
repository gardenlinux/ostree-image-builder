#!/usr/bin/env bash

set -eufo pipefail

set -x

rm -rf .build
./build ostreeRepo

REPO=$(find . -name 'ostreeRepo*trixie*.ostreeRepo.tar.gz')

cp $REPO features/ostreeImage/ostree-debian-repo-$(dpkg --print-architecture).tar.gz
cp $REPO features/ostreeRepo/ostree-debian-repo-$(dpkg --print-architecture).tar.gz

./build ostreeImage
rm -rf .build/ostreeRepo*
echo zsh >> features/ostreeRepo/pkg.include
./build ostreeRepo
mkdir -p .build/repo/debian-repo-$(dpkg --print-architecture)
tar xzvf $REPO -C .build/repo/debian-repo-$(dpkg --print-architecture)
pushd .build/repo/debian-repo-$(dpkg --print-architecture)
python3 -m http.server 9090 &
popd
