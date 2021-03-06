#!/bin/bash
rm ./output/images/*.dtb
make linux-rebuild -j8
make
