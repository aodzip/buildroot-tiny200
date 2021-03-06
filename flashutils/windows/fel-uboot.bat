@echo off
set SELFPATH=%~dp0
%SELFPATH%\bin\sunxi-fel.exe -p uboot output\images\u-boot-sunxi-with-spl.bin
