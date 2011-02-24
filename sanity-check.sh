#!/bin/bash

cd $(dirname $0)/src

echo
echo Check for missing files in updater-script.in:
echo ---------------------------------------------
echo
find system/ -type f  \
    | grep -v ^system/ramdisk/ \
    | while read x
do
    printf "  %-50s   " $x
    echo $(grep $x META-INF/com/google/android/updater-script.in)
done

echo
echo Check for obsolete files in updater-script.in:
echo ----------------------------------------------
echo
grep set_perm META-INF/com/google/android/updater-script.in \
    | cut -f 2 -d \" \
    | while read x
do
    printf "  %-50s   " $x
    ls -ld .$x
done

echo