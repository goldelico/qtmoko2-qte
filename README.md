QT-Embedded deb tree

Cross-Compiling for armhf:
 - Install Cross-Compiler fro armhf from emdebian: https://wiki.debian.org/CrossToolchains#Installation
 - install build dependencies: sudo apt-get install pkg-config debhelper libz-dev:armhf libsqlite3-dev:armhf
 - build deb: dpkg-buildpackage -a armhf -b

Build on armhf:
 - install build dependencies: sudo apt-get install pkg-config debhelper libz-dev libsqlite3-dev
 - build deb: dpkg-buildpackage -a armhf -b
