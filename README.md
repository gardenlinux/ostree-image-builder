# OSTree Image Builder for Garden Linux and Debian

[![Repo](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml)
[![Image](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml)

> [!IMPORTANT]
> This repository is part of a proof of concept.
The Garden Linux team does not provide any support or guarantee for this repository.
Feel free to open an issue if something does not work, but please be aware of the experimental status of this repository.

Builder for [OSTree](https://ostreedev.github.io/ostree/)-based operating system images using the [Garden Linux Builder](https://github.com/gardenlinux/builder).

See [this blog post series for background information on the PoC and its motivation](https://blogs.sap.com/2023/07/10/making-an-immutable-image-based-operating-system-out-of-garden-linux/).

Refer to [the Garden Linux README for setup instructions for the Builder](https://github.com/gardenlinux/gardenlinux#build).

## Repo Structure

The `debian` directory contains a build for a debian trixie image.
It takes packages from the Debian apt repositories.

The `gardenlinux` directory contains a build for a gardenlinux today image.
It takes packages from the Garden Linux apt repositories.
This directory contains a lot of code taken from the [gardenlinux/gardenlinux](https://github.com/gardenlinux/gardenlinux) repo.

## Building

This repo contains two os builder definitions.

Builds can be parameterized to change certain default values.
To change any of the values, create a file using the parameter name inside the feature directory.
This might be needed in both the `ostreeRepo` and the `ostreeImage` feature.

- `REMOTE_URL`: Hostname to use as OSTree remote, default value is `http://ostree.gardenlinux.io`
- `OS_NAME`: OS Name (Stateroot) used for OSTree, default value is either `debian` or `gardenlinux`, change this if you want to build a custom OS
- `REMOTE_NAME`: Name for the OSTree remote (similar to remote 'origin' in git), default value is `main`

### Debian

To build the debian image yourself, run inside the `debian` directory:

```bash
# Optional: To build the OSTree Repo
$ ./build ostreeRepo
# To build the bootable image
$ ./build ostreeImage
```

> [!NOTE]
> The `ostreeImage` will download a copy of the OSTree repository from the Garden Linux artifact storage.
You don't need to run `ostreeRepo` locally.
To build an image based on your self-created repo, copy the output file from the `ostreeRepo` build to `debian/features/ostreeImage/ostree-debian-repo-(amd64/arm64).tar.gz`, depending on your local architecture.
This applies both to the Garden Linux and the Debian builder.

### Garden Linux

Additionally to the build parameters defined above, the Garden Linux build has another parameter called `BUILD_VARIANT`.

To build the Garden Linux yourself, run inside the `gardenlinux` directory:

```bash
# Required: Set the platform. Must match between what is set in the BUILD_VARIANT file and in the repo argument.
# Allowed values for PLATFORM: kvm, metal
$ PLATFORM=kvm
$ echo $PLATFORM > features/ostreeRepo/BUILD_VARIANT
$ echo $PLATFORM > features/ostreeImage/BUILD_VARIANT
# Optional: To build the OSTree Repo
$ ./build "$PLATFORM"_dev_curl-ostreeRepo
# To build the bootable image
$ ./build ostreeImage
```

> [!NOTE]
> The `ostreeImage` will download a copy of the OSTree repository from the Garden Linux artifact storage.
You don't need to run `ostreeRepo` locally.
To build an image based on your self-created repo, copy the output file from the `ostreeRepo` build to `gardenlinux/features/ostreeImage/ostree-gardenlinux-repo-$(PLATFORM)-(amd64/arm64).tar.gz`, depending on your local architecture and the selected platform.
This applies both to the Garden Linux and the Debian builder.

Alternatively, use the `./ostree-build.sh` script:

```bash
./ostree-build.sh kvm
./ostree-build.sh metal
```

## Running

To boot any of the images, use the `start-vm` script from the root of this repository:

```bash
$ gardenlinux/bin/start-vm debian/.build/*ostreeImage-*-trixie-*.ostree.raw
$ gardenlinux/bin/start-vm gardenlinux/.build/*ostreeImage-*-today-*.ostree.raw
```

Check for the actual name of the image in the `.build` directory.

## Upgrading

Inside the booted vm, you can run the `ostree-upgrade` script to upgrade your OS to the latest version.

## More information

Refer to the [OSTree command man page](https://ostreedev.github.io/ostree/man/ostree.html) for instructions of using the cli.
