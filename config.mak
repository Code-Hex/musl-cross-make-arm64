# Drop some features for faster and smaller builds
COMMON_CONFIG += --disable-nls
GCC_CONFIG += --disable-libquadmath --disable-decimal-float
GCC_CONFIG += --disable-libitm --disable-fixed-point

# Explicitly enable libisl support to avoid opportunistic linking
ISL_VER = 0.21
ISL_SITE = https://downloads.sourceforge.net/project/libisl

