;# $Id: comment.pl,v 3.0 1993/08/18 12:10:50 ram Exp $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log: comment.pl,v $
;# Revision 3.0  1993/08/18  12:10:50  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub rcscomment {
	local($file) = @_;
	local($comment) = '';
	open(FILE,$file);
	while (<FILE>) {
		if (/^(.*)\$Log[:\$]/) {	# They know better than us (hopefully)
			$comment = $1;
			last;
		}
	}
	close FILE;
	unless ($comment) {
		if ($file =~ /\.SH$|[Mm]akefile/) {	# Makefile template
			$comment = '# ';
		} elsif ($file =~ /\.U$/) {			# Metaconfig unit
			$comment = '?RCS: ';
		} elsif ($file =~ /\.man$/) {		# Manual page
			$comment = "''' ";
		} elsif ($file =~ /\.\d\w?$/) {		# Manual page
			$comment = "''' ";
		} elsif ($file =~ /\.[chyl]$/) {	# C source
			$comment = " * ";
		} elsif ($file =~ /\.e$/) {			# Eiffel source
			$comment = "-- ";
		} elsif ($file =~ /\.pl$/) {		# Perl library
			$comment = ";# ";
		}
	}
	$comment;
}

