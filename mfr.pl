#!/usr/bin/perl
use File::Copy;
use Data::Dumper;
use File::Path qw(make_path);;

if ($#ARGV != 1) {
	print "Usage: $0 <sourceDier> <targetDir> \n";
	exit 1;
	}

my $sdir = $ARGV[0];
my $tdir = $ARGV[1];
if ( ! -d $sdir) {
	print "Error: source dir <$sdir> doesn't exist!\n";
	}

if ( ! -d $tdir) {
	print "Error: source dir <$tdir> doesn't exist!\n";
	}

chdir($sdir);
my @files = `ls`;
print "files:";
print Dumper @file;

# moves file renamed after FTP to target directory on target machine.
# renaming replaces string Z-Z with / for target file.
# Assumes target directory exists (to create via tar xvf) of dir structure.

foreach my $f (@files) {
	chomp($f);
	my $dpart = $f;
	my $fpart = $f;
	$dpart =~ s/Z-Z/\//;
	$dpart =~ s/\s*//g;
	print "d=<$dpart>; ";
	print "copying $f to $tdir/$dpart \n";
	move("$f", "$tdir/$dpart");
}
