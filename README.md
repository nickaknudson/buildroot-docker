# buildroot-docker
A buildroot environment container for docker.
This repository containerizes the [buildroot dependencies](https://buildroot.org/downloads/manual/manual.html#requirement) using [docker](https://www.docker.com/).

# Building Docker
Building container:

    docker build -t nickaknudson/buildroot .

Pushing to docker:

    docker push nickaknudson/buildroot

# Building Buildroot
Enter the build environment:

    docker run -it -v $(pwd):/home/buildroot/buildroot-external -w /home/buildroot/buildroot-external nickaknudson/buildroot /bin/bash

Clone buildroot:

    BUILDROOT_VERSION=2016.11.2
    git clone --branch $BUILDROOT_VERSION --depth=1 git://git.buildroot.net/buildroot ~/buildroot

Build:

    make O=~/buildroot-output BR2_DL_DIR=~/buildroot-dl BR2_EXTERNAL=~/buildroot-external -C ~/buildroot

Copy the build products from the container back to the host machine:

    cp -R ~/buildroot-output/images .
