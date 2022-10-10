#!/bin/bash
# vim: set ts=4:

set -eu

srcdir="$PWD"
target_arch="aarch64 x86_64"
cross_make_ver=0.9.9
cross_make_dir="$srcdir/musl-cross-make-${cross_make_ver}"

_musl_path() {
	local arch="$1"
	local machine_arch="$(uname -m)"
	if [ $arch == $machine_arch ]; then
		echo $arch-linux-musl-native
	else
		echo $arch-linux-musl-cross
	fi
}

curl -LO "https://github.com/richfelker/musl-cross-make/archive/v${cross_make_ver}.tar.gz"

tar xvf "v${cross_make_ver}.tar.gz"
cp config.mak $cross_make_dir

cd $cross_make_dir
for _arch in $target_arch; do
	make install TARGET="${_arch}-linux-musl"
	dirname=$(_musl_path $_arch)
	mv output $dirname
	tar czf "${dirname}.tar.gz" $dirname
	mv "${dirname}.tar.gz" $srcdir
done
