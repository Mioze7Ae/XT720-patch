#!/bin/bash

cd $(dirname $0)/src

find system -type f  \
    | grep -v ^system/ramdisk/ \
    | while read x
do
    adb shell md5sum /$x
    md5sum $x
done | uniq -uw 32
