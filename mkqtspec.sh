
#!/bin/bash -e

# Generate Qt mkspecs based on the Debian host architecture.

DEB_HOST_ARCH=$(dpkg-architecture -qDEB_HOST_ARCH)
DEB_HOST_GNU_TYPE=$(dpkg-architecture -qDEB_HOST_GNU_TYPE)

# Standard Linux platform
mkdir -p source/mkspecs/linux-debian-$DEB_HOST_ARCH

cp source/mkspecs/linux-arm-gnueabi-g++/qplatformdefs.h \
    source/mkspecs/linux-debian-$DEB_HOST_ARCH/

cat > source/mkspecs/linux-debian-$DEB_HOST_ARCH/qmake.conf << EOF
MAKEFILE_GENERATOR      = UNIX
TARGET_PLATFORM         = unix
TEMPLATE                = app
CONFIG                  += qt warn_on release incremental link_prl gdb_dwarf_index
QT                      += core gui
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

QMAKE_CC                = $DEB_HOST_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK              = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_HOST_GNU_TYPE-g++

QMAKE_AR                = $DEB_HOST_GNU_TYPE-ar cqs
QMAKE_OBJCOPY           = $DEB_HOST_GNU_TYPE-objcopy
QMAKE_STRIP             = $DEB_HOST_GNU_TYPE-strip

load(qt_config)
EOF

# Embedded Linux platform (QWS)
mkdir -p source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH

cp source/mkspecs/qws/linux-generic-g++/qplatformdefs.h \
    source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH/

cat > source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH/qmake.conf << EOF
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
include(../../common/qws.conf)

QMAKE_CC                = $DEB_HOST_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK              = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_HOST_GNU_TYPE-g++

QMAKE_AR                = $DEB_HOST_GNU_TYPE-ar cqs
QMAKE_OBJCOPY           = $DEB_HOST_GNU_TYPE-objcopy
QMAKE_STRIP             = $DEB_HOST_GNU_TYPE-strip

load(qt_config)
EOF
