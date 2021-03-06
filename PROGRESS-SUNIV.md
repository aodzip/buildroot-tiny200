# Progress of F1C100s/F1C200s Driver Support
## Working & Tested
### Boot Device:
- MMC 0
- MMC 1
- SPI NOR Flash
- SPI NAND Flash
### U-Boot Driver:
- Basic LCD
- GPIO Backlight
- SF Devices
- MTD Devices
- USB Peripheral
- UMS USB Mass Storage Drive Emulator
- DFU Firmware Downloader
  - MMC 0
  - MMC 1
  - SPI NOR
  - SPI NAND
- TFCard Firmware Downloader
  - SPI NOR
  - SPI NAND
### Linux Driver:
- Simple Peripheral: GPIO, SPI, UART, IIC, SDIO, PWM
- DMA Controller
- Audio Codec: Playback, Mic-IN
- USB: OTG Mode, Peripheral Mode, Host Mode
- DVP Camera: OV2640, OV5640
- Display Engine: Frontend, Backend, TCON
- Keypad ADC
- AW9523B GPIO Expender
- X-Powers AXP199 PMIC
## Should working && Not tested
### U-Boot Driver:
- PWM Backlight
### Linux Driver:
- Audio Codec: FM-IN, Line-IN
- IR Receiver
- Cedar Video Engine
## Work-In-Progress && Partially working
### Linux Driver:
- TV(CVBS) Encoder
- TV(CVBS) Decoder
## Unsupported
... below and not mentioned devices.
### Linux Driver:
- DE-interlace **Not familiar**
- Touchscreen Sensor **Lack of test hardware**
- Digital Audio **Lack of test hardware**
- RSB Bus **Lack of test hardware**
- OWA Bus **Lack of test hardware**
