%define fontname %NAME%
#%define fontconf  ??-%{fontname}.conf

Name:           %{fontname}-fonts
Version:        %VERSION%
Release:        1%{?dist}
Summary:        WenQuanYi Zen Hei - A Compact CJK Font Derived from Droid Family

Group:          User Interface/X
License:        GPLv3 with exceptions
URL:            http://wenq.org/enindex.cgi
Source0:        http://downloads.sourceforge.net/wqy/%{fontname}-%{version}.tar.gz
BuildRoot:      %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

BuildArch:      noarch
BuildRequires:  fontpackages-devel
Requires:       fontpackages-filesystem

%description
%INFO%

%prep
%setup -q -n %{fontname}


%build


%install
rm -fr %{buildroot}

install -m 0755 -d %{buildroot}%{_fontdir}
install -m 0644 -p *.ttc %{buildroot}%{_fontdir}

#install -m 0755 -d %{buildroot}%{_fontconfig_templatedir} \
#                   %{buildroot}%{_fontconfig_confdir}

#install -m 0644 -p %{fontconf} \
#        %{buildroot}%{_fontconfig_templatedir}/%{fontconf}

#ln -s %{_fontconfig_templatedir}/%{fontconf} \
#      %{buildroot}%{_fontconfig_confdir}/%{fontconf}

install -m 0755 -d %{buildroot}%{_bindir}


%clean
rm -fr %{buildroot}


%_font_pkg -f ??-%{fontname}*.conf *.ttc

%doc AUTHORS ChangeLog COPYING README INSTALL
%dir %{_fontdir}
%attr(744 ,root ,root) %{_bindir}/%{setscript}


%changelog

