########################################################################
# Makefile generated from Makefile.SH on ma 24 elo    06.59.48 1998

SHELL = /bin/sh
JMAKE = jmake
TOP = ../../..
CURRENT = lib/C/fake
DIR = lib/C/fake/
INSTALL = /p/bin/ginstall
INSTALLDIR = /p/bin/ginstall -d

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
MAKE = make
MV = /usr/bin/mv
PRIVLIB = /u/vieraat/vieraat/jhi/Perl/lib/dist
RM = /usr/bin/rm -f

########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.1 1994/10/29 15:46:30 ram Exp ram $

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0.1.1 1994/01/24 13:43:44 ram Exp ram $
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
# Revision 3.0.1.1  1994/01/24  13:43:44  ram
# patch16: created
#

FILES = dup2.C getopt.C rename.C scandir.C setsid.C

INSTALLFLAGS = -m 444

all::

install::
	@for dir in $(PRIVLIB)/lib/C/fake; do \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		(set -x; test -d $$dir || $(INSTALLDIR) $$dir); \
	done

install:: $(FILES)
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(FILES); do \
		(set -x; $(INSTALL) -c $(INSTALLFLAGS) $$i $(PRIVLIB)/lib/C/fake); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(FILES); do \
		(set -x; $(RM) $(PRIVLIB)/lib/C/fake/$$i); \
	done

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

