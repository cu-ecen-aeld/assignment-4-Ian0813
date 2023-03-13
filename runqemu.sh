#!/bin/bash
#Script to run QEMU for buildroot as the default configuration qemu_aarch64_virt_defconfig
#Host forwarding: Host Port 10022 ->> QEMU Port 22 
#Author: Siddhant Jajoo.

WORK_DIR=$(cd -P $(dirname $0) && pwd)

if [ -d "${WORK_DIR}/output" ];
then
    IMAGE_DIR="${WORK_DIR}/output/images"
else
    IMAGE_DIR="${WORK_DIR}/buildroot/output/images"
fi

qemu-system-aarch64 \
    -M virt  \
    -cpu cortex-a53 -nographic -smp 1 \
    -kernel ${IMAGE_DIR}/Image \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0,hostfwd=tcp::10022-:22 \
    -device virtio-net-device,netdev=eth0 \
    -drive file=${IMAGE_DIR}/rootfs.ext4,if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 -device virtio-rng-pci
