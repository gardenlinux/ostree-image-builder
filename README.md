# OSTree Image Builder

[![Repo](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/repo.yml)
[![Image](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml/badge.svg)](https://github.com/gardenlinux/ostree-image-builder/actions/workflows/image.yml)

> [!IMPORTANT]
> This repository is part of a proof of concept.
The Garden Linux team does not provide any support or gurantee for this repository.

Builder for [OSTree](https://ostreedev.github.io/ostree/)-based operating system images using the [Garden Linux Builder](https://github.com/gardenlinux/builder).

See [this blog post series for background information on the PoC and its motivation](https://blogs.sap.com/2023/07/10/making-an-immutable-image-based-operating-system-out-of-garden-linux/).

This repo contains two os builder definitions.

The `debian` directory contains a build for a debian trixie image.

The `gardenlinux` directory contains a build for a gardenlinux today image.
This directory contains a lot of code taken from the [gardenlinux/gardenlinux](https://github.com/gardenlinux/gardenlinux) repo.
