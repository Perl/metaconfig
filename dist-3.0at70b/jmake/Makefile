########################################################################
# Makefile generated from Makefile.SH on ma 24 elo    06.59.45 1998

SHELL = /bin/sh
JMAKE = jmake
TOP = ..
CURRENT = jmake
DIR = jmake/
INSTALL = /p/bin/ginstall
INSTALLDIR = /p/bin/ginstall -d

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
L = 1
MANSRC = /u/vieraat/vieraat/jhi/Perl/man/man1
MAKE = make
MKDEP = /m/fs/work/work/permanent/perl/mc/dist-3.0@70b/mkdep $(DPFLAGS) --
MV = /usr/bin/mv
PRIVLIB = /u/vieraat/vieraat/jhi/Perl/lib/dist
RM = /usr/bin/rm -f
SCRIPTDIR = /u/vieraat/vieraat/jhi/Perl/bin
SED = /usr/bin/sed

########################################################################
# Automatically generated parameters -- do not edit

SCRIPTS =  jmake jmkmf

########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.2 1995/01/11 14:49:55 ram Exp ram $
########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0.1.2 1995/03/21 08:34:16 ram Exp ram $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# $X-Log: Jmakefile,v $
# Revision 3.0.1.2  1995/03/21  08:34:16  ram
# patch52: now installs new fixcpp script in the private libdir
#
# Revision 3.0.1.1  1994/01/24  13:42:36  ram
# patch16: added dependency generation stage
#
# Revision 3.0  1993/08/18  12:04:09  ram
# Baseline for dist 3.0 netwide release.
#

all:: Index

local_realclean::
	$(RM) Index

Index: bindex
	chmod +x bindex
	./bindex

all:: jmake jmkmf

local_realclean::
	$(RM) jmake jmkmf

jmake: jmake.SH
	/bin/sh jmake.SH

jmkmf: jmkmf.SH
	/bin/sh jmkmf.SH


install:: $(SCRIPTS) $(LSCRIPTS)
	@for file in $(SCRIPTS) $(LSCRIPTS); do \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(INSTALL) -c -m 555 $$file $(SCRIPTDIR)); \
	done

deinstall::
	@for file in $(SCRIPTS) $(LSCRIPTS); do \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(RM) $(SCRIPTDIR)/$$file); \
	done

install.man::
	@if test "$(MANSRC)"; then \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for file in $(SCRIPTS); do \
	(set -x; \
	$(INSTALL) -c -m 444 $$file.man $(MANSRC)/$$file.$(L)); \
	done; \
	else exit 0; fi

deinstall.man::
	@if test "$(MANSRC)"; then \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for file in $(SCRIPTS); do \
	(set -x; $(RM) $(MANSRC)/$$file.$(L)); \
	done; \
	else exit 0; fi

all:: bindex fixcpp

local_realclean::
	$(RM) bindex fixcpp

bindex: bindex.SH
	/bin/sh bindex.SH

fixcpp: fixcpp.SH
	/bin/sh fixcpp.SH


install::
	@for dir in $(PRIVLIB) $(PRIVLIB)/files; do \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; test -d $$dir || $(INSTALLDIR) $$dir); \
	done

deinstall::
	$(RM) -r $(PRIVLIB) $(PRIVLIB)/files

install:: Index
	$(INSTALL) -c -m 444 Index $(PRIVLIB)

deinstall::
	$(RM) $(PRIVLIB)/Index

install:: bindex
	$(INSTALL) -c -m 555  bindex $(PRIVLIB)

deinstall::
	$(RM) $(PRIVLIB)/bindex

install:: fixcpp
	$(INSTALL) -c -m 555  fixcpp $(PRIVLIB)/files

deinstall::
	$(RM) $(PRIVLIB)/files/fixcpp

install:: files/Jmake*
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in files/Jmake*; do \
	(set -x; $(INSTALL) -c -m 444 $$i $(PRIVLIB)/files); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in files/Jmake*; do \
	(set -x; $(RM) $(PRIVLIB)/files/$$i); \
	done

BINSH = jmake.SH fixcpp.SH

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	grep '^\$$grep' $(BINSH) | \
	$(SED) -e "s/^.*' \([^ ]*\) >>\([^ ]*\)/\2: \1/" \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

########################################################################
# Common rules for all Makefiles -- do not edit

emptyrule::

clean: local_clean
realclean: local_realclean
clobber: local_clobber

local_clean::
	$(RM) core *~ *.o

local_realclean:: local_clean

local_clobber:: local_realclean
	$(RM) Makefile config.sh

Makefile.SH: Jmakefile
	-@if test -f $(TOP)/.package; then \
	if test -f Makefile.SH; then \
	echo "	$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~"; \
	$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~; \
	fi; \
	echo "	$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT)" ; \
	$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT) ; \
	else touch $@; exit 0; fi

Makefile: Makefile.SH
	/bin/sh Makefile.SH

tags::
	$(CTAGS) -w *.[ch]
	$(CTAGS) -xw *.[ch] > tags

local_clobber::
	$(RM) tags

########################################################################
# Empty rules for directories with no sub-directories -- do not edit

install::
	@echo "install in $(CURRENT) done."

deinstall::
	@echo "deinstall in $(CURRENT) done."

install.man::
	@echo "install.man in $(CURRENT) done."

deinstall.man::
	@echo "deinstall.man in $(CURRENT) done."
Makefiles::

Makefiles.SH::

########################################################################
# Dependencies generated by make depend
# DO NOT DELETE THIS LINE -- make depend relies on it
jmake: ../pl/tilde.pl 
