# $Id: errnolist.mk,v 3.0.1.1 1994/01/24 13:59:32 ram Exp ram $
#
#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 4.0.
#
# Original Author: Harlan Stenn <harlan@mumps.pfcs.com>
#
# $Log: errnolist.mk,v $
# Revision 3.0.1.1  1994/01/24  13:59:32  ram
# patch16: now uses modern shell metaconfig symbols
#
# Revision 3.0  1993/08/18  12:04:36  ram
# Baseline for dist 3.0 netwide release.
#
#
# Make rules for the errnolist stuff

case "$errnolist" in
'') ;;
*)
    $spitshell >>Makefile <<!GROK!THIS!
$errnolist_c: $errnolist_SH $errnolist_a
	sh ./$errnolist_SH

!GROK!THIS!
    ;;
esac

$spitshell >>Makefile <<!GROK!THIS!
ERRNOLIST_OBJ=$errnolist_o
!GROK!THIS!

$spitshell >>Makefile <<'!NO!SUBS!'

foo: foo.o $(ERRNOLIST_OBJ)
	$(CC) -o $@ foo.o $(ERRNOLIST_OBJ)
!NO!SUBS!
