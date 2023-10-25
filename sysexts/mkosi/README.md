Tested with debian trixie and the following installed packages:

```
sudo apt install mkosi systemd-boot dosfstools mtools
```

First, build the base image (needed to create diff images)

```
debian-testing-base/build.sh
```

Now you can create the debug image.

```
debug/build.sh
```
