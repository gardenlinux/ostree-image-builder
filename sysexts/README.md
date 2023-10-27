# System Extensions

[System Extensions](https://uapi-group.org/specifications/specs/extension_image/#sysext-system-extension) ([man page](https://www.freedesktop.org/software/systemd/man/latest/systemd-sysext.html)) are a way to add software to immutable os trees.

## Structure

This directory contains multiple extensions for proof of concept purposes.

`custom` contains system extensions built without additional tooling.

`mkosi` contains system extensions built via [mkosi](https://github.com/systemd/mkosi)

Refer to the README files in subsequent sub directories.

## Usage

1: Copy extensions (`raw` files or directories) to `/var/lib/extensions/`

2: Merge them into your OS tree via:

```
sudo systemd-sysext merge --force
```
