#!/bin/bash

cd ramdisk
rm ../patch/system/ramdisk.tar
tar czf ../patch/system/ramdisk.tar --exclude=.gitignore --owner=0 --group=0 *
cd ..

cd patch
zip -rn .zip:.tar ../patch-$(date +%Y%m%d-%H%M%S) *
cd ..
