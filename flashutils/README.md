# Flashing Tools

## Install driver
- [Linux](linux/README.md)
- [Windows](windows/README.md)

## Helper script
- fel-uboot.sh/bat: Run U-Boot in RAM by FEL mode.
- fel-linux.sh/bat: Run the whole firmware in RAM by FEL mode.
- dfu-nand-all.sh/bat: Flash SPI-NAND by DFU mode.
- dfu-nor-all.sh/bat: Flash SPI-NOR by DFU mode.
- dfu-nand-all.sh/bat: Flash MMC Device by DFU mode.
### Dangerous script
- flash-mmc-flasher.sh: Create a TF card for flashing SPI NOR/NAND to **/dev/sdb**
- flash-mmc-all.sh: Flash sysimage-sdcard.img to **/dev/sdb**

## How to use
- Install drivers first
- Launch one of dfu script you need, the script will wait for the device.
- Put the device in U-Boot mode.(Press RESET key or use fel-uboot.sh/bat for a device without bootloader)
- Wait for the dfu script finish.

## Known Issues
- Flashing NAND target may report error message, mostly can ignore.
- Flashing MMC target need partition first, empty mmc device may fail.
