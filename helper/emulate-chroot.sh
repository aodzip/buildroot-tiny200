#!/usr/bin/sudo bash

cleanup() {
    umount proc/
    cd ..
    rm -rf chroot
}

if [ -d "output" ]
then
    cd output
    if [ -d "chroot" ]
    then
        cd chroot
        cleanup
    fi
    set -e
    mkdir -p chroot
    cd chroot
    tar xf ../images/rootfs.tar .
    mount -t proc /proc proc/
    cp /usr/bin/qemu-arm-static usr/bin/qemu-arm-static
    echo "Warning: Shared procfs ENABLED!!!"
    chroot . /bin/sh
    cleanup
fi
