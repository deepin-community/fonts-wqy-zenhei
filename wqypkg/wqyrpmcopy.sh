#!/bin/sh
############################################################
#             WenQuanYi Font Packaging System
#
#  wqyrpmcopy.sh: script to copy rpm source files to the 
#                 packaging folder
#
#  Author: Qianqian Fang <fangq at nmr.mgh.harvard.edu>
#  History:  
#      2009/05/26    Initial version for MicroHei
#
############################################################

if [ $# -ne 2 ]; then
     echo 1>&2 Usage: $0 package-name version
     exit 2
fi

PKGNAME=$1
VERSION=$2
#INFO=`awk '/I. About this font/{dop=1;} /^$/{if(dop>0) dop++;} /./{if(dop==2) print " " $0;}' README*`

FONTDIR=rpmroot/${PKGNAME}-fonts/
SPECFILE=rpmroot/${PKGNAME}-fonts/${PKGNAME}-fonts.spec

if [ ! -d $FONTDIR ]; then
     echo 1>&2 $FONTDIR does not exist, please run wqyrpmmkdir.sh first
     exit 2
fi

cp -a AUTHORS* $FONTDIR
cp -a ChangeLog* $FONTDIR
cp -a INSTALL* $FONTDIR
cp -a README* $FONTDIR

cp -a $PKGNAME.* $FONTDIR
cp -a LICENSE* $FONTDIR

[ -d rpmsrc ] && cp -a rpmsrc/* rpmroot/${PKGNAME}-fonts

awk '/I. About this font/{dop=1;} /^$/{if(dop>0) dop++;} /./{if(dop==2) print " " $0;}' README* > pkg.info
cat rpmsrc/${PKGNAME}-fonts.spec | sed -e '/%INFO%/{r pkg.info' -e 'd;}' > $SPECFILE

sed -i "s/%NAME%/$PKGNAME/g"  $SPECFILE
sed -i "s/%VERSION%/$VERSION/g"  $SPECFILE

