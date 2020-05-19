#!/bin/bash

set -eo pipefail

if [[ -z "${QNX_SOURCE_SCRIPT}" ]]; then
    echo "Set the environment variable QNX_SOURCE_SCRIPT to specify the path to qnxsdp-env.sh, it's probably where you installed the software tools: /blah/qnx700/qnxsdp-env.sh"
    exit 1
fi

if [[ -z "${LDK_QNX_INSTALL_FOLDER}" ]]; then
    echo "Set the environment variable LDK_QNX_INSTALL_FOLDER to specify where dependencies should be installed to."
    exit 1
fi

. "${QNX_SOURCE_SCRIPT}"

qnx_arch=aarch64le
target_platform_triple=aarch64-unknown-nto-qnx7.0.0

OS=nto-qnx
CFLAGS="-fPIC -Vgcc_ntoaarch64le" 
CC="$QNX_HOST/usr/bin/qcc"
CXX="${QNX_HOST}/usr/bin/q++"

RANLIB="${QNX_HOST}/usr/bin/ntoaarch64-ranlib" 
AR="${QNX_HOST}/usr/bin/ntoaarch64-ar"
LD="${QNX_HOST}/usr/bin/ntoaarch64-ld"

#RANLIB="${QNX_HOST}/usr/bin/${target_platform_triple}-ranlib" 
#AR="${QNX_HOST}/usr/bin/${target_platform_triple}-ar"
#LD="${QNX_HOST}/usr/bin/${target_platform_triple}-ld"

./configure  \
  CC=$CC \
  CXX=$CXX \
  CFLAGS="$CFLAGS" \
  RANLIB=$RANLIB \
  AR=$AR \
  LD=$LD \
  OS=$OS \
  --build=i686-pc-linux \
  --host="$target_platform_triple" \
  --enable-shared \
  --prefix=${LDK_QNX_INSTALL_FOLDER}

make
#make && make check
