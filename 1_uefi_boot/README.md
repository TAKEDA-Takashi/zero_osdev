# 1. UEFI Boot

macOS環境で実行する手順。

```bash
$ sudo chmod 777 /usr/local
$ brew install dosfstools
$ sudo chmod 755 /usr/local
$ brew install qemu
$ brew install --cask hex-fiend

$ export PATH=$PATH:/usr/local/Cellar/dosfstools/4.2/sbin/

$ qemu-img create -f raw disk.img 200M
$ mkfs.fat -n 'MIKAN OS' -s 2 -f 2 -R 32 -F 32 disk.img
$ mkdir mnt
$ hdiutil attach -mountpoint mnt disk.img
$ mkdir -p mnt/EFI/BOOT
$ cp BOOTX64.EFI mnt/EFI/BOOT/
$ hdiutil detach mnt

$ curl -O https://raw.githubusercontent.com/uchan-nos/mikanos-build/master/devenv/OVMF_CODE.fd
$ curl -O https://raw.githubusercontent.com/uchan-nos/mikanos-build/master/devenv/OVMF_VARS.fd

$ mkdir ../devenv
$ mv OVMF_* ../devenv

$ qemu-system-x86_64 \
  -drive if=pflash,file=../devenv/OVMF_CODE.fd,format=raw \
  -drive if=pflash,file=../devenv/OVMF_VARS.fd,format=raw \
  -drive file=disk.img,index=0,media=disk,format=raw
```
