#!/bin/sh
############################################################
#             WenQuanYi Font Packaging System
#
#  wqydebcopy.sh: script to copy deb source files to the
#                 packaging folder
#
#  Author: Qianqian Fang <fangq at nmr.mgh.harvard.edu>
#  History:
#      2009/05/26    Initial version for MicroHei
#      2009/10/02    i18n translation support
############################################################

if [ $# -lt 2 ]; then
     echo 1>&2 Usage: $0 package-name version 'defaultconf'
     exit 2
fi

PKGNAME=$1
VERSION=$2
DEFAULTCFG=$3

#INFO=`awk '/I. About this font/{dop=1;} /^$/{if(dop>0) dop++;} /./{if(dop==2) print " " $0;}' README*`

FONTDIR=debian/usr/share/fonts/wenquanyi/$PKGNAME
DOCDIR=debian/usr/share/doc/wenquanyi/$PKGNAME
CONFDIR=debian/etc/fonts/conf.avail
I18NDIR=debian/usr/share/locale
BINDIR=debian/usr/bin
MENUDIR=debian/usr/share/applications
ICONDIR=debian/usr/share/pixmaps

if [ ! -d $FONTDIR ]; then
     echo 1>&2 $FONTDIR does not exist, please run makewqydebdir.sh first
     exit 2
fi

cp -a AUTHORS* $DOCDIR
cp -a ChangeLog* $DOCDIR
cp -a INSTALL* $DOCDIR
cp -a README* $DOCDIR

cp -a $PKGNAME.* $FONTDIR

for fn in COPYING*; do
   cp -a COPYING* $FONTDIR; break;
done

for fn in LICENSE*; do
   cp -a LICENSE* $FONTDIR; break;
done

for fn in *.conf; do
   cp -a *.conf $CONFDIR; break;
done

for fn in $DEFAULTCFG; do
   cp -a $fn $FONTDIR; break;
done

if [ -f ${PKGNAME}-cfg ]; then
    cp -a ${PKGNAME}-cfg $BINDIR
fi

for fn in *set; do
   cp -a *set $BINDIR; break;
done

for fn in *.desktop; do
   cp -a *.desktop $MENUDIR; break;
done

if [ -d pixmap ]; then
    mkdir -p $ICONDIR
    cp -a pixmap/* $ICONDIR
fi

[ -d debsrc ] && cp -a debsrc/* debian/DEBIAN/
sed -i "s/%NAME%/$PKGNAME/g"  debian/DEBIAN/*
sed -i "s/%VERSION%/$VERSION/g"  debian/DEBIAN/*

#sed -i "s/%INFO%/$INFO/g"  debian/DEBIAN/control
#sed -i "s/^&/\n/g"  debian/DEBIAN/control
awk '/I. About this font/{dop=1;} /^$/{if(dop>0) dop++;} /./{if(dop==2) print " " $0;}' README* >> debian/DEBIAN/control

# install .mo files
if [ -d i18n ]; then
    for lang in `ls -1 i18n | sed -e 's/^i18n\///g'`
    do
	if [ -f i18n/$lang/*.mo ]; then
		mkdir -p $I18NDIR/$lang/LC_MESSAGES/; 
		cp -a i18n/$lang/*.mo $I18NDIR/$lang/LC_MESSAGES/
	fi
    done
fi
