#!/bin/bash
# Changing these values may result in no picture for some modes!

logo_path=$1
fastboot_path=$2
corrupt_path=$3
logo2_path=$4

payload_limit1=36352

python bin/logo_gen.py "$logo_path" $payload_limit1 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "LOGO PICTURE IS LARGE IN SIZE"
  echo "Quitting"
  rm -f output.img
  exit 1
fi
mv output.img temp/logo.img

payload_limit2=220672

python bin/logo_gen.py "$fastboot_path" $payload_limit2 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FASTBOOT PICTURE IS LARGE IN SIZE"
  echo "Quitting"
  rm -f output.img
  exit 1
fi
mv output.img temp/fastboot.img

payload_limit3=61952

python bin/logo_gen.py "$corrupt_path" $payload_limit3 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "CORRUPT PICTURE IS LARGE IN SIZE"
  echo "Quitting"
  rm -f output.img
  exit 1
fi
mv output.img temp/corrupt.img

payload_limit4=39424

python bin/logo_gen.py "$logo2_path" $payload_limit4 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "LOGO2 PICTURE IS LARGE IN SIZE"
  echo "Quitting"
  rm -f output.img
  exit 1
fi
mv output.img temp/logo2.img

cat temp/logo.img temp/fastboot.img temp/corrupt.img temp/logo2.img > "output_splash.img"

