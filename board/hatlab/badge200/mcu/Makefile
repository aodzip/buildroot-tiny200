#全局设定

MCU = atmega328p
#MCU型号
CLOCK = 16000000UL
#MCU时钟
LFUSE = 0xFF
#低熔丝位
HFUSE = 0xDF
#高熔丝位
PROJECT = firmware
#项目名称
SOURCEDIR = ./src
#源码目录
USRDEF = 
#用户全局定义

#二进制文件设定
CC = avr-gcc
#编译器
OBJCOPY = avr-objcopy
#链接器
SIZER = avr-size
#固件大小检查
PROGRAMMER = avrdude
#下载器
DEBUGGER = avarice
#调试器

#GDB调试服务器设定
DBGADDR = 127.0.0.1
#IP地址
DBGPORT = 4242
#端口号
######################以下内容一般不需要更改######################

ISP = usbasp

DEFINES = -DF_CPU=$(CLOCK) $(USRDEF)
OPTIMIZE = -Os -mcall-prologues -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums -g -Wall -Wextra

CFLAGS = -std=c99 -mmcu=$(MCU) $(DEFINES) $(OPTIMIZE) -I $(SOURCEDIR)
FFLAGS = -R .eeprom -R .fuse -R .lock -R .singature
SFLAGS = --mcu=$(MCU)
DBGFLAGS = --part $(MCU) --debugwire --jtag usb --mkII $(DBGADDR):$(DBGPORT)

SOURCES = $(shell find "$(SOURCEDIR)" -name "*.cpp" -o -name "*.c" -o -name "*.s")
OBJECTS = $(patsubst %.s, %.o, $(patsubst %.c, %.o, $(patsubst %.cpp, %.o, $(SOURCES))))

all: $(PROJECT).hex

$(PROJECT).hex : $(PROJECT).elf
	$(OBJCOPY) $(FFLAGS) -O ihex $(PROJECT).elf $(PROJECT).hex
	$(SIZER) $(SFLAGS) $(PROJECT).elf
	$(SIZER) $(SFLAGS) $(PROJECT).hex
	
$(PROJECT).elf : $(OBJECTS)
	$(CC) -Wl,-Map,$(PROJECT).map -o $(PROJECT).elf $(CFLAGS) $(OBJECTS) 

.s.o:
	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cpp.o:
	$(CC) $(CFLAGS) -c $< -o $@

fuse:
	$(PROGRAMMER) -c $(ISP) -p $(MCU) -e -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -B 32

flash: $(PROJECT).hex
	$(PROGRAMMER) -c $(ISP) -p $(MCU) -e -U flash:w:$(PROJECT).hex

debug: $(PROJECT).elf
	$(DEBUGGER) $(DBGFLAGS)

clean:
	find src -name "*.o"  | xargs rm -f
	rm -f $(PROJECT).map $(PROJECT).elf $(PROJECT).hex
	
#Makefile By Aodzip