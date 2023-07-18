
## buildroot for usb display for F1C200s demo 
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

# windows driver install / windows驱动安装
1. 预编译好的驱动包，https://github.com/chuanjinpang/windows_win10_idd_xfz1986_usb_display_drv_f1c200s/tree/master/test_drv
2. 也可以自己使用vs2015安装，
## 安装方法 
1. 因为没有签名，使用的测试版本，需要用管理员权限打开test sign mode. 命令：
   bcdedit /set testsigning on
   然后重启电脑，生效后，桌面右下角会有test mode的水印信息。
3. 在设备管理器中，找到我们的设备，需要把设备插入，然后查找驱动路径。

plugin usb to windows, install windows driver, maybe need change resolution for display.

# refer project or web pages, thanks for these.
1. https://github.com/aodzip/buildroot-tiny200
2. https://whycan.com/t_8114.html   Baremetal hardware JPEG-decoder example (F1C100S)
3. https://whycan.com/t_5429.html   f1c100s成功运行jpeg硬解码demo，但输出还是有问题

## 重要说明:
当前有一个严重的问题， 硬解jpg数据时会有大概1%的概率会出错，生成屏幕闪烁一下，如上图。 这应该是和USB传输相关，当USB不工作时，没有发现硬解出错的问题。

解决方案： 1.找全志支持解决。 2.workaround 使用直接传输rgb565, VGA 640*480 能30fps.

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
