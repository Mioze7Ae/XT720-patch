#!/bin/bash

cd $(dirname "$0")

if [ -z "$1" ] ; then
    echo Usage: $0 tag
    exit 1
else
    echo
    echo Tagging updater-script
    sed "s/XxXxXxXxXxXxXxXx/$1/" \
	src/META-INF/com/google/android/updater-script.in \
	> src/META-INF/com/google/android/updater-script

    echo
    echo Creating src/system/ramdisk.tar
    echo
    rm -f src/system/ramdisk.tar
    tar czf src/system/ramdisk.tar \
	--exclude=.gitignore --owner=0 --group=0 \
	--transform=s,^src/system/ramdisk/,, \
	src/system/ramdisk/*
    tar tvzf src/system/ramdisk.tar

    echo
    echo Creating $1.zip
    echo
    cd src
    zip -rn .zip:.tar "../updates/$1" * \
	-x system/ramdisk/\* .gitignore \
	META-INF/com/google/android/updater-script.in
fi
