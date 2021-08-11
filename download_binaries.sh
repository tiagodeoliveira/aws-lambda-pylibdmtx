#!/bin/bash

set -e

if [ -z "${I_AM_ON_DOCKER}" ];then
    docker run -w /building -v `pwd`:/src -e I_AM_ON_DOCKER=yes -it amazonlinux:2 /src/download_binaries.sh
else
    echo "================================================================="
    echo "Fetching dependencies"
    echo "================================================================="
    yum update
    yum -y install git autoconf libtool make yumdownloader yum-utils rpmdevtools tree

    echo "================================================================="
    echo "Creating libdmtx binaries"
    echo "================================================================="
    git clone https://github.com/dmtx/libdmtx.git
    cd libdmtx
    ./autogen.sh
    ./configure
    make
    make install
    cp /usr/local/lib/libdmtx* /src/py_dmtx_layer/lib/
    cd ..

    echo "================================================================="
    echo "Getting ld and objdump"
    echo "================================================================="
    yumdownloader --resolve binutils
    rpmdev-extract *rpm
    cp binutils-*/usr/bin/ld.bfd /src/py_dmtx_layer/bin/ld
    cp binutils-*/usr/bin/objdump /src/py_dmtx_layer/bin/
    cp binutils-*/usr/lib64/lib* /src/py_dmtx_layer/lib/

    echo "================================================================="
    echo "Finished"
    echo "================================================================="
    tree /src
fi