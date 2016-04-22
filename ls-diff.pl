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
    "c|copy"	=> \my $opt_c,
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
	$m{$_}{$t} = {
	    dir   => $File::Find::dir,
	    unit  => $u,
	    size  => length ($u),
	    lines => ($u =~ tr/\n/\n/),
	    };
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

    my $gd = length diff (\$g->{unit}, \$d->{unit});
    my $dm = length diff (\$d->{unit}, \$m->{unit});
    my $gm = length diff (\$g->{unit}, \$m->{unit});

    printf "%3d %5d/%3d %6d %5d/%3d %6d %5d/%3d %6d %s\n", $i++,
	$g->{size}, $g->{lines}, $gd,
	$d->{size}, $d->{lines}, $dm,
	$m->{size}, $m->{lines}, $gm,
	$u;
    $opt_l and say "    $m{$u}{$_}{dir}/$u" for qw( g d m );

    extdiff ($u, sort split // => $opt_d);

    $opt_d eq "dg" and system "diff", "-w", "$d->{dir}/$u", "$g->{dir}/$u";
    $opt_d eq "gm" and system "diff", "-w", "$g->{dir}/$u", "$m->{dir}/$u";
    }

sub extdiff {
    my ($u, $from, $to) = (@_, "", "");

    my $f = $m{$u}{$from} or return;
    my $t = $m{$u}{$to}   or return;

    my %tag = (
	d => "dst",
	g => "git",
	m => "mod",
	);
    my $F = $tag{$from};
    my $T = $tag{$to};

    my $ff = "$f->{dir}/$u";
    my $tf = "$t->{dir}/$u";

    if ($opt_c) {
	unlink $ff;
	system "cp", "-fp", $tf, $ff;
	}

    open my $fh, "-|", "diff -w $ff $tf";
    while (<$fh>) {
	s/^</$F </;
	s/^>/$T >/;
	print;
	}
    close $fh;
    } # extdiff
