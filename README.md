# buildroot for usb display for F1C200s demo 
20230705: 
Experience version Internal testing only. 

how to build:
1. decrypt patch file

cd board/allwinner/suniv-f1c100s/patch/linux
cat 0019-add-usb-display-demo-src.patch.des3.udisp_xfz1986 | openssl des3 -d -k pass_word > 0019-add-usb-display-demo-src.patch

2. just follow below step to get img

3. run it:
connect f1c200s serial in shell.

echo >  /sys/kernel/config/usb_gadget/g1/UDC
cd lib/modules/5.4.99/kernel/drivers/usb/gadget/function
insmod jdec.ko 
insmod udisp_xfz1986_demo.ko
/opt/devmset 0x1c20000 0x90001f00 1
/opt/devmd 0x1c20000

plugin usb to windows, install windows driver, maybe need change resolution for display.



# Buildroot Package for Allwinner SIPs
Opensource development package for Allwinner F1C100s & F1C200s

## Driver support
Check this file to view current driver support progress for F1C100s/F1C200s: [PROGRESS-SUNIV.md](PROGRESS-SUNIV.md)

Check this file to view current driver support progress for V3/V3s/S3/S3L: [PROGRESS-V3.md](PROGRESS-V3.md)

## Install

### Install necessary packages
``` shell
sudo apt install wget unzip build-essential git bc swig libncurses-dev libpython3-dev libssl-dev
sudo apt install python3-distutils
```

### Download BSP
**Notice: Root permission is not necessery for download or extract.**
```shell
git clone https://github.com/aodzip/buildroot-tiny200
```

## Make the first build
**Notice: Root permission is not necessery for build firmware.**

### Apply defconfig
**Caution: Apply defconfig will reset all buildroot configurations to default values.**

**Generally, you only need to apply it once.**
```shell
cd buildroot-tiny200
make widora_mangopi_r3_defconfig
```

### Regular build
```shell
make
```

## Speed up build progress

### Download speed
Buildroot will download sourcecode when compiling the firmware. You can grab a **TRUSTWORTHY** archive of 'dl' folder for speed up.

### Compile speed
If you have a multicore CPU, you can try
```
make -j ${YOUR_CPU_COUNT}
```
or buy a powerful PC for yourself.

## Flashing firmware to target
You can flash a board by Linux (Recommended) or Windows system.
### [Here is the manual.](flashutils/README.md)

## Helper Scripts
- rebuild-uboot.sh: Recompile U-Boot when you direct edit U-Boot sourcecode.
- rebuild-kernel.sh: Recompile Kernel when you direct edit Kernel sourcecode.
- emulate-chroot.sh: Emulate target rootfs by chroot.
