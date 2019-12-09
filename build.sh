#!/bin/sh
set -e
nasm simple_chroot.S -felf64
ld simple_chroot.o --strip-all -o main
