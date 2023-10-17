#!/usr/bin/env bash
set -e
set -u
set -o pipefail

platforms=("metal" "kvm")
architectures=("arm64")

pushd gardenlinux
for platform in "${platforms[@]}"
do
    for architecture in "${architectures[@]}"
    do
        ./build ${platform}_dev_curl-ostreeRepo-${architecture}
    done
done
popd

pushd debian
for architecture in "${architectures[@]}"
do
    ./build ostreeRepo-${architecture}
done
popd
