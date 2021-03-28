#!/bin/bash

export PATH=$PATH:/usr/local/Cellar/dosfstools/4.2/sbin/

if [[ ! -f disk.img ]]; then
  qemu-img create -f raw disk.img 200M
  mkfs.fat -n 'MY RUST OS' -s 2 -f 2 -R 32 -F 32 disk.img
fi

if [[ ! -d mnt ]]; then
  mkdir mnt
fi

hdiutil attach -mountpoint mnt disk.img
mkdir -p mnt/EFI/BOOT
cp target/x86_64-unknown-uefi/release/uefi_rust.efi mnt/EFI/BOOT/BOOTX64.EFI
hdiutil detach mnt

qemu-system-x86_64 \
  -drive if=pflash,file=../devenv/OVMF_CODE.fd,format=raw \
  -drive if=pflash,file=../devenv/OVMF_VARS.fd,format=raw \
  -drive file=disk.img,index=0,media=disk,format=raw &