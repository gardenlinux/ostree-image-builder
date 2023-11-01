#!/usr/bin/env bash

set -eufo pipefail

set -x

rm -rf .build
./build ostreeRepo
cp .build/ostreeRepo-${dpkg --print-architecture}-trixie*.ostreeRepo.tar.gz features/ostreeImage/ostree-debian-repo-${dpkg --print-architecture}.tar.gz
./build ostreeImage
rm -rf .build/ostreeRepo*
echo zsh >> features/ostreeRepo/pkg.include
./build ostreeRepo
mkdir -p .build/repo
tar xzvf .build/ostreeRepo-${dpkg --print-architecture}-trixie*.ostreeRepo.tar.gz -C .build/repo
