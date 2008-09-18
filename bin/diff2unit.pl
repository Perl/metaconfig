#!/pro/bin/perl

use strict;
use warnings;

use File::Find;

print STDERR "Reading Units ...";
my (%U, %P);
local $/ = undef;
find (sub {
    -f  && m/\.U$/ or return;
    -l and return;
    my $pri = 0;
    $File::Find::dir =~ m:^metaconfig/dist-3.0at70b: and $pri = 1;
    $File::Find::dir =~ m:^metaconfig/U:             and $pri = 2;
    exists $U{$_} && $pri < $P{$_} and return;
    open my $U, "< $_" or die "$_: $!";
    $P{$_} = $pri;
    $U{$_} = [ $File::Find::name, <$U> ];
    }, "metaconfig");
my @U = sort keys %U;
print STDERR "\b\b\b", scalar @U, "\n";

for (@ARGV) {
    s:^(\d\d)(\d+)$:gzcat perl-current-diffs/${1}000/$1$2.gz |:;
    }

my $patch_nr = 0;
local $/ = "\n+++";
while (<>) {
    if (m/^Change (\d+) by/) {
	$patch_nr = $1;
	next;
	}
    m:^ perl/Configure\b: or next;
    print STDERR "Patch accepted ...\n";
    s:End of Patch\b.*::;

    my $part = 0;
    foreach my $patch (split m:\@\@[-\s\d,+]+\@\@\n:) {
	$patch =~ m:^ perl/Configure\b: and next;
	my $org = join "\n", grep s/^[- ]//, split m/\n/, $patch;
	print STDERR "Search for:\n--8<---\n$org\n-->8---\n";
	my @units;
	foreach my $U (@U) {
	    index ($U{$U}[1], $org) >= 0 and push @units, $U{$U}[0];
	    }
	printf "%5d/%03d %s\n", $patch_nr, ++$part, join ", ", @units;
	}
    }
