;# $Id: patseq.pl,v 3.0.1.1 1993/08/24 12:22:14 ram Exp $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log: patseq.pl,v $
;# Revision 3.0.1.1  1993/08/24  12:22:14  ram
;# patch3: created
;#
;#
# Compute patch sequence by scanning the bugs directory and looking for
# .logs and/or .mods files to determine what was the last issued patch series.
sub patseq {
	local($cur) = @_;		# Current patch level
	local(@seq);			# Issued patch sequence
	local($i);
	for ($i = 1; $i <= $cur; $i++) {
		push(@seq, $i) if -f "bugs/.logs$i" || -f "bugs/.mods$i";
	}
	@seq;
}

