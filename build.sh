#!/usr/bin/env bash

platforms=("metal" "kvm")
architectures=("amd64" "arm64")

pushd gardenlinux

for platform in "${platforms[@]}"
do
    for architecture in "${architectures[@]}"
    do
        ./build ${platform}_dev_curl-ostreeRepo-${architecture}
    done
done




podp
