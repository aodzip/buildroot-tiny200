#!/bin/bash
mkfs.jffs2 --pagesize=0x800 --eraseblock=0x20000 --pad=0x1000000 -n -d "${1}" -o vendor.img
