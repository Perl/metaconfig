#!/usr/bin/perl

# This script reorders config_h.SH after metaconfig
# Changing metaconfig is too complicated
#
# Copyright (C) 2005-2005 by H.Merijn Brand (m)'05 [25-05-2005]
#
# You may distribute under the terms of either the GNU General Public
# License or the Artistic License, as specified in the README file.

use strict;
use warnings;

my ($cSH, $ch, @ch, %ch) = ("config_h.SH");
open $ch, "<$cSH" or die "Cannot open $cSH: $!\n";
{   local $/ = "\n\n";
    @ch = <$ch>;
    close  $ch;
    }

my @ref;
sub ch_index ()
{
    %ch = ();
    foreach my $ch (0 .. $#ch) {
	while ($ch[$ch] =~ m{^/\* ([A-Z]\w+)}gm) {
	    $ch{$1} = $ch;
	    push @{$ref[$ch]}, $1;
	    }
	}
    } # ch_index

ch_index;
my @CH = @ch;
my %RF;
foreach my $ch (0 .. $#CH) {
    $CH[$ch] =~ s{/\*.*?\*/\s*}{}gis;
    while ($CH[$ch] =~ m{\b([A-Z]\w+)}g) {
	exists $ch{$1} or  next;
	$ch{$1} == $ch and next;
	#print STDERR "$ref[$ch][0] ($ch) ref to $1 ($ch{$1})\n";
	$RF{$1}{$ref[$ch][0]}++;
	}
    }
foreach my $r (sort keys %RF) {
    my $R = sprintf "%-20s", $r;
    print "    $r => [ qw ( @{[sort keys %{$RF{$r}}]}\t) ],\n";
    }

my %dep = (
    # This symbol must be defined BEFORE ...
    BYTEORDER		=> [ qw( UVSIZE				) ],
    LONGSIZE		=> [ qw( BYTEORDER			) ],
    MULTIARCH		=> [ qw( BYTEORDER MEM_ALIGNBYTES	) ],
    USE_CROSS_COMPILE	=> [ qw( BYTEORDER MEM_ALIGNBYTES	) ],
    HAS_QUAD		=> [ qw( I64TYPE			) ],
    HAS_GETGROUPS	=> [ qw( Groups_t			) ],
    HAS_SETGROUPS	=> [ qw( Groups_t			) ],
    );

my $CHANGED = 0;
my $changed;
do {
    $changed = 0;
    foreach my $sym (keys %dep) {
	ch_index;
	foreach my $dep (@{$dep{$sym}}) {
	    print STDERR "Check if $sym\t($ch{$sym}) precedes $dep\t($ch{$dep})\n";
	    $ch{$sym} < $ch{$dep} and next;
	    my $ch = splice @ch, $ch{$sym}, 1;
	    splice @ch, $ch{$dep}, 0, $ch;
	    $changed++;
	    $CHANGED++;
	    ch_index;
	    }
	}
    } while ($changed);
