;# $Id: package.pl,v 3.0 1993/08/18 12:10:57 ram Exp $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log: package.pl,v $
;# Revision 3.0  1993/08/18  12:10:57  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub readpackage {
	if (! -f '.package') {
		if (
			-f '../.package' ||
			-f '../../.package' ||
			-f '../../../.package' ||
			-f '../../../../.package'
		) {
			die "Run in top level directory only.\n";
		} else {
			die "No .package file!  Run packinit.\n";
		}
	}
	open(PACKAGE,'.package');
	while (<PACKAGE>) {
		next if /^:/;
		next if /^#/;
		if (($var,$val) = /^\s*(\w+)=(.*)/) {
			$val = "\"$val\"" unless $val =~ /^['"]/;
			eval "\$$var = $val;";
		}
	}
	close PACKAGE;
}

