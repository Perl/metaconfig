########################################################################
# Makefile generated from Makefile.SH on ma 24 elo    06.59.49 1998

SHELL = /bin/sh
JMAKE = jmake
TOP = ../..
CURRENT = mcon/man
DIR = mcon/man/
INSTALL = /p/bin/ginstall

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
L = 1
MANSRC = /u/vieraat/vieraat/jhi/Perl/man/man1
MAKE = make
MV = /usr/bin/mv
RM = /usr/bin/rm -f

########################################################################
# Automatically generated parameters -- do not edit

MANPAGE =  $(MPAGES)

########################################################################
# New suffixes and associated building rules -- edit with care

.SUFFIXES: .SH .1

.SH.1:
	/bin/sh $<

########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.1 1994/10/29 15:46:30 ram Exp ram $

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0 1993/08/18 12:10:13 ram Exp ram $
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
# Revision 3.0  1993/08/18  12:10:13  ram
# Baseline for dist 3.0 netwide release.
#

MPAGES = metaconfig.$(L) metalint.$(L) metaxref.$(L)

all:: $(MPAGES)

local_realclean::
	$(RM) $(MPAGES)

install.man::
	@if test "$(MANSRC)"; then \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		for file in $(MPAGES); do \
			(set -x; $(INSTALL) -c -m 444 $$file $(MANSRC)); \
		done; \
	else exit 0; fi

deinstall.man::
	@if test "$(MANSRC)"; then \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		for file in $(MPAGES); do \
			(set -x; $(RM) $(MANSRC)/$$file); \
		done; \
	else exit 0; fi

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

