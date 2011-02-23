#!/bin/bash

# rm -f ramdisk.tar
# cd ramdisk
# tar czf ../ramdisk.tar --owner=0 --group=0 *
# cd ..
# tar tvzf ramdisk.tar

# cp ramdisk.tar patch/system/ramdisk.tar

cd patch
zip -rn .zip:.tar ../patch-$(date +%Y%m%d-%H%M%S) *
cd ..
