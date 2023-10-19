#!/bin/bash
set -o nounset
set -o errexit

if [[ "$#" -ne 1 ]]; then
	echo "Usage: $(basename "$0") kvm|metal"
	exit 1
fi

PLATFORM=$1

echo $PLATFORM > features/ostreeRepo/BUILD_VARIANT
echo $PLATFORM > features/ostreeImage/BUILD_VARIANT
./build "$PLATFORM"_dev_curl-ostreeRepo
./build ostreeImage
