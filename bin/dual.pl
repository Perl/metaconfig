#!/pro/bin/perl

# dual.pl patch-file
#
# will show the e-mail addresses of those whose files are changed by this patch

package Maintainers;

use strict;
use warnings;

use Cwd;
use File::Find;

my $pdir = getcwd;
$< == 203 && -d "/pro/3gl/CPAN" and chdir "/pro/3gl/CPAN/perl";
-d "Porting" or die "You're not in the perl5 root folder\n";

use vars qw(%Modules %Maintainers);
require "Porting/Maintainers.pl";

my %Files;
foreach my $m (keys %Modules) {
    foreach my $f (split m/\s+/ => $Modules{$m}{FILES}) {
	my @f;
	if (-d $f) {
	    find (sub { -f and push @f, $File::Find::name }, $f);
	    }
	else {
	    @f = ($f);
	    }
	for (@f) {
	    $Files{$_} = {
		Module     => $m,
		Maintainer => $Modules{$m}{MAINTAINER},
		};
	    }
	}
    }

my ($pfx, $pwd, $pc) = ("", (getcwd) x 2);
#$pwd =~ m/CPAN/ and ($pc, $pfx) = ("/pro/3gl/CPAN/perl-current", "perl/");

my %fqfn;
find (sub {
    -f or return;	# Only files
    my $f = $File::Find::name;
    $f =~ s{^$pc/}{$pfx}o;
    #print STDERR "$f\n";
    $fqfn{$f} = $f;

    my $x = $f;
    while ($x =~ s{^[^/]+/}{}) {
	if (exists $fqfn{$x} && !ref $fqfn{$x}) {
	    #warn "$f already in top-level. skipped\n";
	    next;
	    }
	push @{$fqfn{$x}}, $f;
	}
    }, $pc);

chdir $pdir;
my @patched_files;
while (<>) {
    m/^(?:\+\+\+|\*\*\*)\s+(\S+)/ or next;

    # now check if the file exists
    my $f = $1;
    $f =~ m/^\d+,\d+$/ and next;	# Grr, diff not -u
    -f "perl/$f" and $f = "perl/$f";

    unless (exists $fqfn{$f}) {
	#print STDERR "finding FQFN for $f ...\n";
	while ($f =~ m{/} && !exists $fqfn{$f}) {
	    $f =~ s{^[^/]*/}{};
	    }
	$f or die "No match for $f\n";
	}

    my $x = $fqfn{$f};
    if (ref $x) {
	my @f = @$x;
	@f == 0 and next;	# Hmmm
	@f > 1 and die "$f matches (@f)\n";
	$x = $f[0];
	}
    push @patched_files, $x;
    }

my (%mod, %mnt);
foreach my $f (@patched_files) {
    exists $Files{$f} or next;	# Not dual
    $mod{$Files{$f}{Module}}++;
    $mnt{$Files{$f}{Maintainer}}++;
    }

if (my @mod = sort { lc $a cmp lc $b } keys %mod) {
    local $" = ", ";
    print "Affected modules: @mod\n";
    print "Maintainers: @{[map { $Maintainers{$_} } keys %mnt]}\n";
    }
