#!/usr/bin/perl

use 5.18.2;
use warnings;

our $VERSION = "0.03";

sub usage {
    my $err = shift and select STDERR;
    say "usage: $0 [--list] [--diff[=gd|dp|gp]] [--diff-flags=--whatever] [--pat=pattern]";
    say "  diff (size) between git / dist / perl";
    say "  where git  (g) is the version from the git repo of meta/dist";
    say "  where dist (d) is the unmodified installed version from dist";
    say "  where perl (p) is the *modified* version for use with perl";
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
    "D|diff-flags=s"	=> \my $opt_D,
    "c|copy"	=> \my $opt_c,

    "p|pat=s"	=> \my $opt_p,
    ) or usage (1);

$opt_D //= "-w";

my $pat = shift // ".";
$pat = qr{$pat};

my %exempt = map {( s/[\s\n].*\z//rs => 1 )} <DATA>;
my %m;

foreach my $u ( [ "g", "dist-git/mcon/U" ],
		[ "d", "dist/U"          ],
		[ "p", "U"               ],
		) {
    my ($t, $dir) = @$u;
    find (sub {
	-l $_   and return;
	m/\.U$/ or  return;
	m{$pat} or  return;

	$exempt{$_} and return;

	my $u = do { local (@ARGV, $/) = $_; <> };
	$m{$_}{$t} = {
	    dir   => $File::Find::dir,
	    unit  => $u,
	    size  => length ($u),
	    lines => ($u =~ tr/\n/\n/),
	    };
	}, $dir);
    }

foreach my $u (keys %m) {
    my $g = $m{$u}{g};
    my $d = $m{$u}{d};
    my $p = $m{$u}{p};

    $m{$u}{gd} = $g && $d ? length diff (\$g->{unit}, \$d->{unit}) : 0;
    $m{$u}{dp} = $d && $p ? length diff (\$d->{unit}, \$p->{unit}) : 0;
    $m{$u}{gp} = $g && $p ? length diff (\$g->{unit}, \$p->{unit}) : 0;
    }

$opt_d //= "";

say "  #     Git             Dist              Perl    Diff Unit";
say "=== ========= ====== ========= ====== ========= ====== ======================";
my $i = 1;
foreach my $u (sort { $m{$b}{gd} <=> $m{$a}{gd} || $m{$b}{dp} <=> $m{$a}{dp} } keys %m) {
    my $d = $m{$u}{d} or next;
    my $p = $m{$u}{p} or next;
    my $g = $m{$u}{g} or next;

    my $gd = $m{$u}{gd};
    my $dp = $m{$u}{dp};
    my $gp = $m{$u}{gp};

    #$gd == 0 || $gd > 1000 and next;

    if ($opt_p) {
	$d->{unit} =~ $opt_p ||
	$p->{unit} =~ $opt_p ||
	$g->{unit} =~ $opt_p or next;
	}

    my $su = $u;
    $gd || $dp || $gp or $su .= "\t** NO CHANGES LEFT **";
    printf "%3d %5d/%3d %6d %5d/%3d %6d %5d/%3d %6d %s\n", $i++,
	$g->{size}, $g->{lines}, $gd,
	$d->{size}, $d->{lines}, $dp,
	$p->{size}, $p->{lines}, $gp,
	$su;
    $opt_l and say "    $_ $m{$u}{$_}{dir}/$u" for qw( g d p );

    extdiff ($u, sort split // => $opt_d);
    }

sub extdiff {
    my ($u, $from, $to) = (@_, "", "");

    my $f = $m{$u}{$from} or return;
    my $t = $m{$u}{$to}   or return;

    my %tag = (
	g => "git",
	d => "dst",
	p => "prl",
	);
    my $F = $tag{$from};
    my $T = $tag{$to};

    my $ff = "$f->{dir}/$u";
    my $tf = "$t->{dir}/$u";

    if ($opt_c) {
	unlink $ff;
	system "cp", "-fp", $tf, $ff;
	}

    open my $fh, "-|", "diff $opt_D $ff $tf";
    while (<$fh>) {
	s/^</$F </;
	s/^>/$T >/;
	print;
	}
    close $fh;
    } # extdiff

__END__
package.U	Will never be equal due to conflicting needs
