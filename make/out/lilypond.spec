Name: lilypond
Version: 1.1.66
Release: 1
Copyright: GPL
Group: Applications/Publishing
Source0: ftp.cs.uu.nl:/pub/GNU/LilyPond/development/lilypond-1.1.66.tar.gz
Summary: A program for printing sheet music.
URL: http://www.cs.uu.nl/~hanwen/lilypond
Packager: Han-Wen Nienhuys <hanwen@cs.uu.nl>
# Icon: lilypond-icon.gif
BuildRoot: /tmp/lilypond-install
Prereq: tetex

%description 

LilyPond is a music typesetter.  It produces beautiful sheet music
using a high level description file as input.  LilyPond is part of 
the GNU Project.



%prep
%setup
%build
./configure --disable-checking --disable-debugging --enable-printing --prefix=/usr --disable-optimise --enable-shared
make all
ln -s /usr/share/texmf/fonts/tfm/public/cm/ tfm

make -C Documentation  || true
make htmldoc || true


%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/tmp/lilypond-rpm-doc
mkdir htmldocs
tar -C htmldocs -xzf out/htmldoc.tar.gz
mkdir -p out/examples/
tar -cf - input/  | tar -C out/examples/ -xf-

strip lily/out/lilypond midi2ly/out/midi2ly
make prefix="$RPM_BUILD_ROOT/usr" install
# gzip -9fn $RPM_BUILD_ROOT/usr/info/* || true

mkdir -p $RPM_BUILD_ROOT/etc/profile.d
cp buildscripts/out/lilypond-profile $RPM_BUILD_ROOT/etc/profile.d/lilypond.sh
cp buildscripts/out/lilypond-login $RPM_BUILD_ROOT/etc/profile.d/lilypond.csh

%post

touch /tmp/.lilypond-install
rm `find /var/lib/texmf -name 'feta*pk -print' -or -name 'feta*tfm -print'` /tmp/.lilypond-install
# /sbin/install-info /usr/info/lilypond.info.gz /usr/info/dir || true

%preun
if [ $1 = 0 ]; then
 true #   /sbin/install-info --delete /usr/info/lilypond.info.gz /usr/info/dir || true
fi


%files
%doc htmldocs/
%doc out/examples/

# hairy to hook it in (possibly non-existing) emacs
%doc mudela-mode.el

# this gets too messy...
# %doc input/*.ly
# verbatim include of input: list the directory without issuing a %dir 

/usr/bin/convert-mudela
/usr/bin/mudela-book
/usr/bin/ly2dvi
/usr/bin/lilypond
/usr/bin/midi2ly
/usr/man/man1/midi2ly.1
/usr/man/man1/lilypond.1
/usr/man/man1/mudela-book.1
/usr/man/man1/ly2dvi.1
/usr/man/man1/convert-mudela.1
/usr/share/lilypond/
/usr/share/locale/*/LC_MESSAGES/lilypond.mo
/etc/profile.d/lilypond.*

