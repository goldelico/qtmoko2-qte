# This is a deb build tree for QT-Embedded, utilizing debhelper.

## Cross-Compiling for armhf:  
1.  Install Cross-Compiler for armhf from emdebian:
    [https://wiki.debian.org/CrossToolchains#Installation](https://wiki.debian.org/CrossToolchains#Installation)
2.  install build dependencies:  
    `sudo apt-get install pkg-config debhelper libz-dev:armhf libsqlite3-dev:armhf libglib2.0-dev:armhf libgstreamer0.10-dev:armhf libgstreamer-plugins-base0.10-dev:armhf`
4.  Get the Code:
    `git clone git://git.goldelico.com/qtmoko2-qte.git`
3.  build deb:  
    `cd qtmoko2-qte; dpkg-buildpackage -a armhf -b`

## Building natively on armhf:
1.  install build dependencies:  
    `sudo apt-get install build-essential pkg-config debhelper libz-dev libsqlite3-dev libglib2.0-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev`
2.  Get the Code:
    `git clone git://git.goldelico.com/qtmoko2-qte.git`
3.  build deb (remove the -b option to build the source package as well):
    `cd qtmoko2-qte; dpkg-buildpackage -b`
