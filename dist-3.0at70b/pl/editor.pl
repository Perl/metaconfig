;# $Id: editor.pl,v 3.0.1.1 1993/08/25 14:08:07 ram Exp $
;#
;#  Copyright (c) 1991-1993, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 3.0.
;#
;# $Log: editor.pl,v $
;# Revision 3.0.1.1  1993/08/25  14:08:07  ram
;# patch6: created
;#
# Compute suitable editor name
sub geteditor {
	local($editor) = $ENV{'VISUAL'};
	$editor = $ENV{'EDITOR'} unless $editor;
	$editor = $defeditor unless $editor;
	$editor = 'vi' unless $editor;
	$editor;
}

