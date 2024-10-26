#!/bin/bash
# vim: set ts=4:

set -eu

srcdir="$PWD"
target_arch="aarch64 x86_64 armv7l"
cross_make_ver=0.9.10
cross_make_dir="$srcdir/musl-cross-make-${cross_make_ver}"

_musl_or_abihf() {
        local arch="$1"
        if [ $arch == "armv7l" ]; then
                echo musleabihf
        else
                echo musl
        fi
}

_musl_path() {
        local arch="$1"
        local machine_arch="$(uname -m)"
        local musl="$(_musl_or_abihf $arch)"
        if [ $arch == $machine_arch ]; then
                echo $arch-linux-$musl-native
        else
                echo $arch-linux-$musl-cross
        fi
}

if [ ! -f v${cross_make_ver}.tar.gz ]; then
    curl -LO "https://github.com/richfelker/musl-cross-make/archive/v${cross_make_ver}.tar.gz"
fi

tar xvf "v${cross_make_ver}.tar.gz"
cp config.mak $cross_make_dir

cd $cross_make_dir
for _arch in $target_arch; do
    if [ "$_arch" == "armv7l" ]; then
        make install TARGET="armv7l-linux-musleabihf" \
            GCC_CONFIG+="--with-arch=armv7-a --with-fpu=vfpv3-d16 --with-float=hard"
    else
        make install TARGET="${_arch}-linux-musl"
    fi
    dirname=$(_musl_path $_arch)
    mv output $dirname
    tar czf "${dirname}.tar.gz" $dirname
    mv "${dirname}.tar.gz" $srcdir
done
