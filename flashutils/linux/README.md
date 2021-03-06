# F1C100s/200s Linux Flash tools

## Build sunxi-tools from source
```shell
sudo apt install pkg-config zlib1g-dev libusb-dev libusb-1.0-0-dev
git clone https://github.com/Icenowy/sunxi-tools.git -b f1c100s-spiflash
cd sunxi-tools
make 
sudo make install
```

## Install dfu-util from apt repository
```shell
sudo apt install dfu-util
```

## Add udev rules for download gadget
```
ACTION!="add", SUBSYSTEM!="usb_device", GOTO="rules_end"

ATTR{idProduct}=="efe8", ATTR{idVendor}=="1f3a", MODE="666"
ATTR{idProduct}=="1010", ATTR{idVendor}=="1f3a", MODE="666"

LABEL="rules_end"
```
Save file as /etc/udev/rules.d/99-allwinnerdl.rules
