# Build your own OSTree-based OS

Image-based systems are (naturally) limited in how customizable they are.
The images built as part of this PoC probably don't contain what you need.

To address this, this document discusses how you can build your own image based on this PoC.

Depending on your needs, you might chose to either base your own image on the Debian apt repositories or the Garden Linux apt repositories.
To get started, clone the [repository](https://github.com/gardenlinux/ostree-image-builder) and either use the `debian` or the `gardenlinux` directory as a starting point.

As an example, we'll build a custom system based on the Debian repositories.

We'll use the [lima-vm development environment](https://github.com/gardenlinux/gardenlinux/tree/main/hack/lima-dev-env), but you might be able to follow along in any recent Linux environment with a container runtime such as podman, ideally debian-based.

You'll want to configure the following build settings:

| Variable     | Default Value                  | Explanation                                                                                                                       |
| ------------ | ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| `REMOTE_URL` | `http://ostree.gardenlinux.io` | This is the hostname part of the URL of your remote repository. Set this to a hostname you control and where you can up the repo. |
| `OS_NAME`    | `debian` or `gardenlinux`      | This is the name of your OS. This will be used as an identifier by OSTree.                                                        |

Inside the lima vm, run the following commands to setup the build:

```
user@dev:~$ git clone https://github.com/gardenlinux/ostree-image-builder florianslinux
Cloning into 'florianslinux'...
user@dev:~$ cd florianslinux/debian
user@dev:~/florianslinux/debian$ REMOTE_URL=http://example.com
user@dev:~/florianslinux/debian$ OS_NAME=florianslinux
user@dev:~/florianslinux/debian$ echo $REMOTE_URL | tee features/{ostreeRepo,ostreeImage}/REMOTE_URL
user@dev:~/florianslinux/debian$ echo $OS_NAME | tee features/{ostreeRepo,ostreeImage}/OS_NAME
```

At this stage, you will want to modify the build definition.
For example, you might want to modify `debian/features/ostreeRepo/pkg.include` which defines the packages used to build the image.
Most likely, you'll want to add packages wich are required for your use-case.

Next, we can build our OSTree repo.
Observe how the build configuration reflects the values you provided:

```
user@dev:~/florianslinux/debian$ ./build ostreeRepo
...
 Build Configuration:
 REMOTE_URL: http://example.com
 REMOTE_REPO_PATH: florianslinux-repo-arm64
 OS_NAME: florianslinux
...

user@dev:~/florianslinux/debian$ ls -lah .build/ostreeRepo-*-trixie-*.ostreeRepo.tar.gz
-rw-r--r-- 1 user user 363M 2023-12-06 18:03 .build/ostreeRepo-arm64-trixie-40ae93b3.ostreeRepo.tar.gz
```

This file contains our newly built _repo_.

Based on that, we can build a bootable disk _image_.
We'll copy the repo `tar.gz` file into the `ostreeImage` directory to build the disk image from the local file.
If we didn't do this, the build would try to download the repo from `http://example.com/ostree-${OS_NAME}-repo-${ARCH}.tar.gz`.

```
user@dev:~/florianslinux/debian$ ARCH=$(dpkg --print-architecture)
user@dev:~/florianslinux/debian$ cp .build/ostreeRepo-${ARCH}-trixie-*.ostreeRepo.tar.gz features/ostreeImage/ostree-${OS_NAME}-repo-${ARCH}.tar.gz
user@dev:~/florianslinux/debian$ ./build ostreeImage
 Found local OSTree repo file at /builder/features/ostreeImage/ostree-florianslinux-repo-arm64.tar.gz, using it to build the image
```

We can boot this image and inspect the OSTree configuration.

This image now expects a remote repository to be served at `http://example.com/florianslinux-repo-arm64`, based on the configuration you provided before.

```
user@dev:~/florianslinux/debian$ ../gardenlinux/bin/start-vm .build/ostreeImage-arm64-trixie-local.ostree.raw
user@70818c14b220:~$ ostree remote show-url main
http://example.com/florianslinux-repo-arm64
user@70818c14b220:~$ ostree admin status
* florianslinux dc790f368399597d499ab89e4dd7809ea961d34b21e987e65f5c7da87746a33d.0
    origin refspec: florianslinux/testing/arm64
user@70818c14b220:~$ ostree log florianslinux/testing/arm64
commit dc790f368399597d499ab89e4dd7809ea961d34b21e987e65f5c7da87746a33d
ContentChecksum:  ed567ccac3762142b410a7836e2c38c6da02a9144b7cf6c13601b1de9518c1f1
Date:  2023-12-06 18:03:15 +0000

    Debian florianslinux-repo-arm64 2023-12-06T18:02UTC

```

The `ostreeRepo` and `ostreeImage` build steps will try to download a repo from `http://example.com/ostree-${OS_NAME}-repo-${ARCH}.tar.gz`, if no local file with that name exists.
The idea is to have this done in CI like for example in [`repo.yml`](../.github/workflows/repo.yml) and [`image.yml`](../.github/workflows/image.yml).

You can see which source repository is used in the log.
Once you've set it up to be available on the remote, you should see a like like this in the build log:

```
Using remote file from http://example.com/ostree-${OS_NAME}-repo-${ARCH}.tar.gz
```

You will want to have regular rebuilds to include security fixes for the operating system.

This is how you can make our own OSTree-based OS.
If you run into issues, while doing this, feel free to open an issue in this repo.
