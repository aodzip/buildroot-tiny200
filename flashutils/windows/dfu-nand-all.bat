@echo off
set SELFPATH=%~dp0
echo | set /p="Waiting for DFU Device";
:loop
echo | set /p="."
for /f %%i in ('%SELFPATH%\bin\dfu-util.exe -l ^| findstr "Found DFU"') do set OUTPUT=%%i
if "%OUTPUT%" == "" goto loop
echo "Gotcha!"
%SELFPATH%\bin\dfu-util.exe -R -a all -D output\images\sysimage-nand.img
@REM %SELFPATH%\bin\dfu-util -a u-boot -D output\images\u-boot-sunxi-with-nand-spl.bin
@REM %SELFPATH%\bin\dfu-util -a kernel.itb -D output\images\kernel.itb
@REM %SELFPATH%\bin\dfu-util -a rom -D output\images\rootfs.squashfs
