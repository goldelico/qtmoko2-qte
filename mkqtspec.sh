#!/bin/bash -e

case "$(cat /etc/debian_version)" in
	8.* )
# read system information from dpkg-architecture to generate qt build configuration
DEB_TARGET_ARCH=$(dpkg-architecture -q"DEB_TARGET_ARCH")
DEB_TARGET_GNU_TYPE=$(dpkg-architecture -q"DEB_TARGET_GNU_TYPE")

# standard target (not needed for embedded build)
mkdir -p source/mkspecs/linux-debian-$DEB_TARGET_ARCH
cp -v source/mkspecs/linux-arm-gnueabi-g++/qplatformdefs.h source/mkspecs/linux-debian-$DEB_TARGET_ARCH/
cat > source/mkspecs/linux-debian-$DEB_TARGET_ARCH/qmake.conf << EOF
MAKEFILE_GENERATOR      = UNIX
TARGET_PLATFORM         = unix
TEMPLATE                = app
CONFIG                  += qt warn_on release incremental link_prl gdb_dwarf_index
QT                      += core gui
QMAKE_INCREMENTAL_STYLE = sublib

include(../common/linux.conf)
include(../common/gcc-base-unix.conf)
include(../common/g++-unix.conf)

# modifications to g++.conf
QMAKE_CC                = $DEB_TARGET_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_TARGET_GNU_TYPE-g++
QMAKE_LINK              = $DEB_TARGET_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_TARGET_GNU_TYPE-g++

# modifications to linux.conf
QMAKE_AR                = $DEB_TARGET_GNU_TYPE-ar cqs
QMAKE_OBJCOPY           = $DEB_TARGET_GNU_TYPE-objcopy
QMAKE_STRIP             = $DEB_TARGET_GNU_TYPE-strip

load(qt_config)
EOF

# embedded target
# based on source/mkspecs/qws/linux-arm-g++
mkdir -p source/mkspecs/qws/linux-debian-$DEB_TARGET_ARCH
cp -v source/mkspecs/qws/linux-generic-g++/qplatformdefs.h source/mkspecs/qws/linux-debian-$DEB_TARGET_ARCH/
cat > source/mkspecs/qws/linux-debian-$DEB_TARGET_ARCH/qmake.conf << EOF
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
include(../../common/qws.conf)

# modifications to g++.conf
QMAKE_CC                = $DEB_TARGET_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_TARGET_GNU_TYPE-g++
QMAKE_LINK              = $DEB_TARGET_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_TARGET_GNU_TYPE-g++

# modifications to linux.conf
QMAKE_AR                = $DEB_TARGET_GNU_TYPE-ar cqs
QMAKE_OBJCOPY           = $DEB_TARGET_GNU_TYPE-objcopy
QMAKE_STRIP             = $DEB_TARGET_GNU_TYPE-strip

load(qt_config)
EOF

	;;

	7.* )
# read system information from dpkg-architecture to generate qt build configuration
DEB_HOST_ARCH=$(dpkg-architecture -q"DEB_HOST_ARCH")
DEB_HOST_GNU_TYPE=$(dpkg-architecture -q"DEB_HOST_GNU_TYPE")

# standard target (not needed for embedded build)
mkdir -p source/mkspecs/linux-debian-$DEB_HOST_ARCH
cp -v source/mkspecs/linux-arm-gnueabi-g++/qplatformdefs.h source/mkspecs/linux-debian-$DEB_HOST_ARCH/
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

# modifications to g++.conf
QMAKE_CC                = $DEB_HOST_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK              = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_HOST_GNU_TYPE-g++

# modifications to linux.conf
QMAKE_AR                = ar cqs
QMAKE_OBJCOPY           = objcopy
QMAKE_STRIP             = strip

load(qt_config)
EOF

# embedded target
# based on source/mkspecs/qws/linux-arm-g++
mkdir -p source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH
cp -v source/mkspecs/qws/linux-generic-g++/qplatformdefs.h source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH/
cat > source/mkspecs/qws/linux-debian-$DEB_HOST_ARCH/qmake.conf << EOF
include(../../common/linux.conf)
include(../../common/gcc-base-unix.conf)
include(../../common/g++-unix.conf)
include(../../common/qws.conf)

# modifications to g++.conf
QMAKE_CC                = $DEB_HOST_GNU_TYPE-gcc
QMAKE_CXX               = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK              = $DEB_HOST_GNU_TYPE-g++
QMAKE_LINK_SHLIB        = $DEB_HOST_GNU_TYPE-g++

# modifications to linux.conf
QMAKE_AR                = ar cqs
QMAKE_OBJCOPY           = objcopy
QMAKE_STRIP             = strip

load(qt_config)
EOF
	;;
esac