#!/pro/bin/perl

use strict;
use warnings;

use File::Find;
use Archive::Tar;

chdir "/pro/3gl/CPAN";

my @today = localtime;
my $today = (($today[5] + 1900) * 100 + $today[4] + 1) * 100 + $today[3];

my @mc;
find (sub { -d or push @mc, $File::Find::name }, "metaconfig");

my $tgz = "/tmp/mc_units-$today.tgz";
unlink $tgz;
Archive::Tar->create_archive ($tgz, 9, sort @mc);
print $tgz, "\t", -s $tgz, "\n";
