#!/bin/bash
echo -n "Waiting for DFU Device";
while [ -z "`dfu-util -l | grep 'Found DFU'`" ]
do
    echo -n ".";
done
echo "Gotcha!";
dfu-util -a u-boot -D output/images/u-boot-sunxi-with-spl.bin
dfu-util -a kernel.itb -D output/images/kernel.itb
dfu-util -a rom -D output/images/rootfs.squashfs 
