# musl-cross-make-arm64

Easily build static-friendly musl-based GCC on arm64 Linux cross-compilers based on [richfelker/musl-cross-make](https://github.com/richfelker/musl-cross-make).

## Requirement

- At least 2GiB RAM
- Environment which is able to build linux
  - Because build Linux headers

If you use ubuntu, you can get the envirioment with just installing these packages.

```
$ sudo apt-get install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm
```

## Usage

```
$ ./build.sh
```

