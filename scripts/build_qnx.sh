#!/bin/bash

set -eo pipefail

if [[ -z "${QNX_SOURCE_SCRIPT}" ]]; then
    echo "Set the environment variable QNX_SOURCE_SCRIPT to specify the path to qnxsdp-env.sh, it's probably where you installed the software tools: /blah/qnx700/qnxsdp-env.sh"
    exit 1
fi

. "${QNX_SOURCE_SCRIPT}"

# ./configure CC="${QNX_BINS}/qcc" CXX="${QNX_BINS}/QCC" CFLAGS="-fpic -Vgcc_ntoaarch64le" CXXFLAGS="-fpic -Vgcc_ntoaarch64le -Y_cxx" OS=qnx7 --target=aarch64-qnx-qnx --host=x86_64-linux-gnu RANLIB="${QNX_BINS}/aarch64-unknown-nto-qnx7.0.0-ranlib" AR="${QNX_BINS}/aarch64-unknown-nto-qnx7.0.0-ar" LD="${QNX_BINS}/aarch64-unknown-nto-qnx7.0.0-ld" LDCXX="${QNX_BINS}/aarch64-unknown-nto-qnx7.0.0-ld"


plain_arch=aarch64-qnx-qnx

CC="$QNX_HOST/usr/bin/qcc"
CFLAGS="-fpic -Vgcc_ntoaarch64le" 
RANLIB="${QNX_HOST}/usr/bin/aarch64-unknown-nto-qnx7.0.0-ranlib" 
AR="${QNX_HOST}/usr/bin/aarch64-unknown-nto-qnx7.0.0-ar"
LD="${QNX_HOST}/usr/bin/aarch64-unknown-nto-qnx7.0.0-ld"
OS=nto-qnx

./configure  \
  CC=$CC \
  CFLAGS="$CFLAGS" \
  RANLIB=$RANLIB \
  AR=$AR \
  LD=$LD \
  OS=$OS \
  --build=x86_64-linux-gnu --target="$plain_arch" --host="$plain_arch" --enable-shared

#./configure CC=$CC CFLAGS="$CFLAGS" RANLIB=$RANLIB AR=$AR LD=$LD OS=$OS --host=x86_64-linux-gnu --target="$plain_arch" --enable-shared

make
#make && make check
