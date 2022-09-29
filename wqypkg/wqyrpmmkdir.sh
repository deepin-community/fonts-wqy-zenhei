#!/bin/sh
############################################################
#             WenQuanYi Font Packaging System
#
#  wqyrpmmkdir.sh: script to create rpm packaging folder structure
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

mkdir -p rpmroot/rpm/BUILD/
mkdir -p rpmroot/rpm/RPMS/
mkdir -p rpmroot/rpm/SOURCES/
mkdir -p rpmroot/rpm/SPECS/
mkdir -p rpmroot/rpm/SRPMS/

mkdir -p rpmroot/${PKGNAME}-fonts
mkdir -p rpmroot/${PKGNAME}-fonts/${PKGNAME}-fonts/
