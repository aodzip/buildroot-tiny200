#!/bin/bash
set -e
STARTDIR=`pwd`
SELFDIR=`dirname \`realpath ${0}\``
MKIMAGE="${HOST_DIR}/bin/mkimage"
IMAGE_ITS="kernel.its"
OUTPUT_NAME="kernel.itb"

echo "${1} ${2}"

[ $# -eq 2 ] || {
    echo "SYNTAX: $0 <output dir> <u-boot-with-spl image>"
    echo "Given: $@"
    exit 1
}

echo "x1"
cp board/allwinner/generic/kernel.its "${BINARIES_DIR}"
cd "${BINARIES_DIR}"
"${MKIMAGE}" -f ${IMAGE_ITS} ${OUTPUT_NAME}
rm ${IMAGE_ITS}

cd "${SELFDIR}/../"
cp splash.bmp "${BINARIES_DIR}/"

cd "${STARTDIR}/"
echo "x2"

board/allwinner/generic/scripts/mknanduboot.sh ${1}/${2} ${1}/u-boot-sunxi-with-nand-spl.bin
echo "x3"
support/scripts/genimage.sh ${1} -c board/allwinner/generic/genimage-sdcard.cfg
echo "x4"
support/scripts/genimage.sh ${1} -c board/allwinner/generic/genimage-nor.cfg
support/scripts/genimage.sh ${1} -c board/allwinner/generic/genimage-nand.cfg
