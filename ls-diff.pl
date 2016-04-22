#!/pro/bin/perl

use 5.18.2;
use warnings;

our $VERSION = "0.01";

sub usage {
    my $err = shift and select STDERR;
    say "usage: $0 [--list] [--diff]";
    exit $err;
    } # usage

use File::Find;
use Text::Diff;
use Getopt::Long qw(:config bundling);
GetOptions (
    "help|?"	=> sub { usage (0); },
    "V|version"	=> sub { say $0 =~ s{.*/}{}r, " [$VERSION]"; exit 0; },

    "l|list!"	=> \my $opt_l,
    "d|diff=s"	=> \my $opt_d,
    ) or usage (1);

my $pat = shift // ".";
$pat = qr{$pat};

my %m;

foreach my $u ( [ "d", "dist/U"          ],
		[ "m", "U"               ],
		[ "g", "dist-git/mcon/U" ],
		) {
    my ($t, $dir) = @$u;
    find (sub {
	-l $_   and return;
	m/\.U$/ or  return;
	m{$pat} or  return;

	my $u = do { local (@ARGV, $/) = $_; <> };
	$m{$_}{$t} = [ $File::Find::dir, $u, length ($u), ($u =~ tr/\n/\n/) ];
	}, $dir);
    }

$opt_d //= "";

say "  #     Git             Dist              Perl    Diff Unit";
say "=== ========= ====== ========= ====== ========= ====== ======================";
my $i = 1;
foreach my $u (sort keys %m) {
    my $d = $m{$u}{d} or next;
    my $m = $m{$u}{m} or next;
    my $g = $m{$u}{g} or next;

    printf "%3d %5d/%3d %6d %5d/%3d %6d %5d/%3d %6d %s\n", $i++,
	$g->[2], $g->[3], length (diff (\$g->[1], \$d->[1])),
	$d->[2], $d->[3], length (diff (\$d->[1], \$m->[1])),
	$m->[2], $m->[3], length (diff (\$g->[1], \$m->[1])),
	$u;
    $opt_l and say "    $m{$u}{$_}[0]/$u" for qw( g d m );

    $opt_d eq "dm" and system "diff", "-w", "$d->[0]/$u", "$m->[0]/$u";
    $opt_d eq "dg" and system "diff", "-w", "$d->[0]/$u", "$g->[0]/$u";
    $opt_d eq "gm" and system "diff", "-w", "$g->[0]/$u", "$m->[0]/$u";
    }
