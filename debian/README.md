# Debian OSTree Builder

This is a experimental repo to build Debian OSTree images.

## Build

This repo is built using the [Garden Linux Builder](https://github.com/gardenlinux/builder#builder), which uses podman, see it's readme for setup instructions.

This repo has two ostree related features (build targets).
You can run them with the following commands:

```bash
$ ./build ostreeRepo
$ ./build ostreeImage
```

For just getting a bootable system, use `ostreeImage`.
This will produce a raw disk image that can be booted in qemu.
See below for the command to boot the image.

`ostreeRepo` will give you an OSTree repo in the form of a tarball.
The output will have a name like `.build/ostreeRepo-*-trixie-*.ostreeRepo.tar.gz`
This is the foundation for building the disk image, but it is also usable as a remote repo for upgrading the system.

## Run

Use the `bin/start-vm` script from [Garden Linux](https://github.com/gardenlinux/gardenlinux/blob/main/bin/start-vm).

Depending on your architecture, it should look like this:

```bash
$ path/to/gardenlinux/bin/start-vm --no-watchdog .build/ostreeImage-arm64-trixie*.ostree.raw
```

```bash
$ path/to/gardenlinux/bin/start-vm --no-watchdog .build/ostreeImage-amd64-trixie*.ostree.raw
```

Check for the actual name of the image in the `.build` directory.

Inside the booted vm, you can run the `ostree-upgrade` script to upgrade your OS to the latest version.

Refer to the [OSTree command man page](https://ostreedev.github.io/ostree/man/ostree.html) for instructions of using the cli.
