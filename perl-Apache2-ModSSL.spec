Name:         perl-Apache2-ModSSL
License:      Artistic License
Group:        Development/Libraries/Perl
Provides:     p_Apache2_ModSSL
Obsoletes:    p_Apache2_ModSSL
Requires:     perl = %{perl_version}
Autoreqprov:  on
Summary:      Perl interface to mod_ssl
Version:      0.03
Release:      1
Source:       Apache2-ModSSL-%{version}.tar.gz
BuildRoot:    %{_tmppath}/%{name}-%{version}-build

%description
Perl interface to mod_ssl



Authors:
--------
    Torsten Förtsch <torsten.foertsch@gmx.net>

%prep
%setup -n Apache2-ModSSL-%{version}
# ---------------------------------------------------------------------------

%build
perl Makefile.PL
make && make test
# ---------------------------------------------------------------------------

%install
[ "$RPM_BUILD_ROOT" != "/" ] && [ -d $RPM_BUILD_ROOT ] && rm -rf $RPM_BUILD_ROOT;
make DESTDIR=$RPM_BUILD_ROOT install_vendor
%{_gzipbin} -9 $RPM_BUILD_ROOT%{_mandir}/man3/Apache2::ModSSL.3pm || true
%perl_process_packlist

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && [ -d $RPM_BUILD_ROOT ] && rm -rf $RPM_BUILD_ROOT;

%files
%defattr(-, root, root)
%{perl_vendorarch}/Apache2
%{perl_vendorarch}/auto/Apache2
%doc %{_mandir}/man3/Apache2::ModSSL.3pm.gz
/var/adm/perl-modules/perl-Apache2-ModSSL
%doc MANIFEST README
