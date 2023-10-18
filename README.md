# OSTree Image Builder

[![Repo](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml)
[![Image](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml)

> [!IMPORTANT]
> This repository is part of a proof of concept.
The Garden Linux team does not provide any support or gurantee for this repository.

Builder for [OSTree](https://ostreedev.github.io/ostree/)-based operating system images using the [Garden Linux Builder](https://github.com/gardenlinux/builder).

See [this blog post series for background information on the PoC and its motivation](https://blogs.sap.com/2023/07/10/making-an-immutable-image-based-operating-system-out-of-garden-linux/).

Refer to [the Garden Linux README for setup instructions for the Builder](https://github.com/gardenlinux/gardenlinux#build).

This repo contains two os builder definitions.

The `debian` directory contains a build for a debian trixie image.
It takes packages from the Debian apt repositories.

To build it yourself, run inside the `debian` directory:

```bash
# Optional: To build the OSTree Repo
$ ./build ostreeRepo
# To build the bootable image
$ ./build ostreeImage
```

> [!NOTE]
> The `ostreeImage` will download a copy of the OSTree repository from the Garden Linux artifact storage.
You don't need to run `ostreeRepo` locally.

The `gardenlinux` directory contains a build for a gardenlinux today image.
It takes packages from the Garden Linux apt repositories.
This directory contains a lot of code taken from the [gardenlinux/gardenlinux](https://github.com/gardenlinux/gardenlinux) repo.

To build it yourself, run inside the `gardenlinux` directory:

```bash
# Optional: To build the OSTree Repo
$ ./build kvm_dev_curl-ostreeRepo
# To build the bootable image
$ ./build ostreeImage
```
