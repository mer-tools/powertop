# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       powertop

# >> macros
# << macros

Summary:    PowerTop is tool that is used for power diagnostics
Version:    2.4
Release:    1
Group:      Applications/System
License:    GPLv2
URL:        https://01.org/powertop/
Source0:    powertop-v%{version}.tar.bz2
Source100:  powertop.yaml
BuildRequires:  pkgconfig(libpci)
BuildRequires:  pkgconfig(ncursesw)
BuildRequires:  gettext
BuildRequires:  intltool
BuildRequires:  libnl-devel

%description
PowerTop is tool that detects which Linux programs
and kernel tunables are resulting in the largest
power consumption and use of battery time. By
fixing (or closing) these applications or
processes, you can immediately see the power
savings in the tool. You'll also see the estimated
time left for battery power if you are running a
laptop.


%prep
%setup -q -n src

# >> setup
# << setup

%build
# >> build pre
%autogen
# << build pre

%configure --disable-static
make %{?jobs:-j%jobs}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%make_install

# >> install post
# << install post

%find_lang powertop

%files -f powertop.lang
%defattr(-,root,root,-)
%doc COPYING
%doc /usr/share/man/man8/powertop.8.gz
%{_sbindir}/powertop
# >> files
# << files
