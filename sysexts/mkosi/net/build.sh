#!/usr/bin/env bash
set -euo pipefail

MYDIR="$(dirname "$(readlink -f "$0")")"

pushd $MYDIR
mkosi build --base-tree=../debian-testing-base --overlay
popd
