#!/bin/sh
############################################################
#             WenQuanYi Font Packaging System
#
#  wqydebmkdir.sh: script to create deb packaging folder structure
#
#  Author: Qianqian Fang <fangq at nmr.mgh.harvard.edu>
#  History:  
#      2009/05/26    Initial version for MicroHei
#
############################################################ 

if [ $# -ne 1 ]; then
     echo 1>&2 Usage: $0 package-name
     exit 2
fi

PKGNAME=$1

FONTDIR=debian/usr/share/fonts/wenquanyi/$PKGNAME
DOCDIR=debian/usr/share/doc/wenquanyi/$PKGNAME
CONFDIR=debian/etc/fonts/conf.avail
I18NDIR=debian/usr/share/locale
BINDIR=debian/usr/bin
MENUDIR=debian/usr/share/applications
ICONDIR=debian/usr/share/pixmaps
   
mkdir -p $FONTDIR
mkdir -p $DOCDIR
mkdir -p debian/DEBIAN/
mkdir -p $BINDIR

for fn in *.desktop; do
   mkdir -p $MENUDIR; break;
done

if [ -d pixmap ]; then
   mkdir -p $ICONDIR
fi

for fn in *.conf; do
   mkdir -p $CONFDIR; break;
done
