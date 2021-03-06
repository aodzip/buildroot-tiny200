#!/bin/bash

UBOOT_OFFSET=32 #0x800/1024
PAGESIZE=2048
BLOCKSIZE=128

set -e
[ $# -eq 2 ] || {
    echo "SYNTAX: $0 <u-boot-with-spl image> <outputfile> "
    echo "Given: $@"
    exit 1
}

OUTPUT="$2"
UBOOT="$1"

TOOLCHECK=$(od --help | grep 'endia')
if [ "$TOOLCHECK" == "" ]; then
	echo "od cmd is too old not support endia"
	exit -1
fi
# SPL-Size is an uint32 at 16 bytes offset contained in the SPL header
#uboot header offset head in include/configs/sunxi-common.h CONFIG_SYS_SPI_U_BOOT_OFFS so spl max size is CONFIG_SYS_SPI_U_BOOT_OFFS
#f1c100s modify CONFIG_SYS_SPI_U_BOOT_OFFS to 0xd000(52K)
SPLSIZE=$(od -An -t u4 -j16 -N4 "$UBOOT" | xargs)
printf "SPLSIZE:%d(0x%x)\n" $SPLSIZE $SPLSIZE
# The u-boot size is an uint32 at (0xd000 + 12) bytes offset uboot start offset 0xd000(52K)
UBOOTSIZE=$(od --endian=big -An -t u4 -j$((53248 + 12)) -N4 "$UBOOT" | xargs)
printf "UBOOTSIZE:%d(0x%x)\n" $UBOOTSIZE $UBOOTSIZE
ALIGNCHECK=$(($PAGESIZE%1024))
if [ "$ALIGNCHECK" -ne "0" ]; then
	echo "Page-size is not 1k alignable and thus not supported by EGON"
	exit -1
fi

KPAGESIZE=$(($PAGESIZE/1024))
SPLBLOCKS=25

echo "Generating boot0 for boot part of max size 0x8000 SPLBLOCKS:$SPLBLOCKS"
dd if="/dev/zero" of="$OUTPUT" bs=1024 count=$((52 - $SPLBLOCKS))

for splcopy in `seq 0 $SPLBLOCKS`;
do
	to=$(($splcopy*$KPAGESIZE))
	echo "Copying block $splcopy to $to" 
	dd if="$UBOOT" of="$OUTPUT" bs=1024 count=1 seek=$to skip=$splcopy conv=notrunc
done

echo "Appending u-boot"
dd if="$UBOOT" of="$OUTPUT" bs=1024 seek=52 skip=$UBOOT_OFFSET conv=notrunc
sync
echo "done"
