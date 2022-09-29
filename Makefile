############################################################
#             WenQuanYi Font Packaging System
#
#  Author: Qianqian Fang <fangq at nmr.mgh.harvard.edu>
#  History:
#      2009/05/26    Initial version for MicroHei
############################################################

PKGNAME=wqy-zenhei
VERSION=0.9.45
DEFAULTCONF=44-wqy-zenhei.conf

deb: i18n
	-wqypkg/wqydebmkdir.sh $(PKGNAME)
	-wqypkg/wqydebcopy.sh  $(PKGNAME) $(VERSION) '$(DEFAULTCONF)'
	-dpkg -b debian $(PKGNAME)-$(VERSION).deb
rpm: i18n
	-wqypkg/wqyrpmmkdir.sh $(PKGNAME)
	-wqypkg/wqyrpmcopy.sh  $(PKGNAME) $(VERSION) '$(DEFAULTCONF)'
	cd rpmroot && tar zcvf $(PKGNAME)-$(VERSION).tar.gz $(PKGNAME)-fonts ; \
	rpmbuild --define="_topdir rpmroot/rpm" -ta $(PKGNAME)-$(VERSION).tar.gz
i18n:
	@for lang in i18n/*;\
	do\
	   if [ -f $$lang/$(PKGNAME).po ]; then\
		msgfmt -o $$lang/$(PKGNAME).mo $$lang/$(PKGNAME).po;\
	   fi;\
	done
clean:
	-rm -rf debian rpmroot pkg.info $(PKGNAME)-$(VERSION).deb $(PKGNAME)-$(VERSION)*.rpm
