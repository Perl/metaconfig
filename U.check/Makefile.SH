case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
: This forces SH files to create target in same directory as SH file.
: This is so that make DEPEND always knows where to find SH derivatives.
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting Makefile (with variable substitutions)"
: This section of the file will have variable substitutions done on it.
: Move anything that needs config subs from !NO!SUBS! section to !GROK!THIS!.
: Protect any dollar signs and backticks that you do not want interpreted
: by putting a backslash in front.  You may delete these comments.
$spitshell >Makefile <<!GROK!THIS!
CC = $cc
CCFLAGS = $ccflags
OPTIMIZE = $optimize
CPPFLAGS = $cppflags
MKDEP = $NONONOmkdep
!GROK!THIS!

: In the following dollars and backticks do not need the extra backslash.
$spitshell >>Makefile <<'!NO!SUBS!'

all:	dummy main
	./dummy
	./main

main:	try1.o try2.o main.o
	$(CC) -o main main.o try1.o try2.o
test:
	./main
clean:	
	rm -f dummy config.h core config.sh
	rm -f try try?.o main.o main core

realclean:	clean
	rm -f Wanted Obsolete check.extra check.wanted build.log
	rm -f Makefile

try1.o:	try1.c config.h

try2.o:	try2.c config.h

main.o:	main.c config.h

DEPEND:		
	$(MKDEP) $(CPPFLAGS) -- try1.c try2.c main.c 
!NO!SUBS!
chmod 755 Makefile
$eunicefix Makefile
