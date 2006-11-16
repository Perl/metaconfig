#!/pro/bin/perl

# (c)'06 H.Merijn Brand [ 16 Nov 2006 ]

# This script combines the output of mkglossary, with the suggested
# patches (see README), and sorts the list

use strict;
use warnings;

my $Pcsh = "Porting/config.sh";
@ARGV = "config.sh";
my @config = <> or die
    "mkgloss uses $Pcsh.sh. You didn't run Configure (yet)\n".
    "so I cannot make a temporary version of it to generate a reliable\n".
    "Glossary!\n";
{   my $drop = 0;
    for (@config) {
	s{\bh.m.brand\@\w+\.nl\b}{hmbrand\@cpan.org};
	s{\b\.xs4all.nl\b}{.cpan.org};
	m/^# Variables propagated from previous config/ and $drop++;
	$drop and $_ = '';
	}
    unlink $Pcsh;
    open my $config, ">", $Pcsh or die "$Pcsh: $!\n";
    print   $config @config;
    close   $config;
    }

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
    s/[ \t]+\n/\n/g;
    print;
    }
