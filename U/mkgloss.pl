#!/pro/bin/perl

# (c)'06 H.Merijn Brand [ 09 Apr 2006 ]

# This script combines the output of mkglossary, with the suggested
# patches (see README), and sorts the list

use strict;
use warnings;

@ARGV = ("U/mkglossary |");
$/ = undef;
my @g = split m{(?<=\n\n)(?=\S)}, <>, -1;

print splice @g, 0, 2;
for (sort { lc $a cmp lc $b } @g) {
    if (m/^make_set_make /) {
	s/Configure -D option/Configure '-D' option/;
	}
    if (m/^n /) {
	s/contains the -n flag/contains the '-n' flag/;
	}
    if (m/^sh /) {
	s/set sh with a -D$/set sh with a '-D'/m;
	s{with -O -Dsh=/bin/whatever -Dstartsh=whatever}
	 {with '-O -Dsh=/bin/whatever -Dstartsh=whatever'};
	}
    if (m/^spitshell /) {
	s/cat or a grep -v for # comments/cat or a grep '-v' for # comments/;
	}
    print;
    }
