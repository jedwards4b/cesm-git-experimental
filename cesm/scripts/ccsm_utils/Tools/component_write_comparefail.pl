#! /usr/bin/env perl
use strict;

if ($#ARGV == -1) {
    die " ERROR cam.buildexe: must specify a caseroot input argument";
}
my ($file) = @ARGV;

my $ndiffs     = `grep RMS $file | wc -l`;
my $nfilldiffs = `grep FILLDIFF $file | wc -l`;

if (($ndiffs > 0) || ($nfilldiffs > 0)) {
    print "$file had the following fields that are NOT b4b  \n";
    print "\n";
}

if ($ndiffs > 0) {
    open(fh,"<$file") or die "Could not open file $file to write";
    while (my $line = <fh>) {
	if ($line =~ /RMS\s+(\S+)\s+(\S+)/) {
	    print "  $line "; 
	}
    }
    close(fh);
}

if ($nfilldiffs > 0) {
    open(fh,"<$file") or die "Could not open file $file to write";
    while (my $line = <fh>) {
	if ($line =~ /FILLDIFF\s+(\S+)/) {
	    print "  $line "; 
	}
    }
    close(fh);
}

exit(0);
