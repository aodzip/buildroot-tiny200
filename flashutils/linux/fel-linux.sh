#!/bin/bash
sunxi-fel -p uboot output/images/u-boot-sunxi-with-spl.bin write 0x80000000 output/images/zImage write 0x80700000 output/images/devicetree.dtb write 0x80708000 output/images/rootfs.cpio.uboot
