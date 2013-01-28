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

foreach my $f (@files) {
	chomp($f);
	my $dpart = $f;
	my $fpart = $f;
	$dpart =~ s/Z-Z.*//;
	$fpart =~ s/.*Z-Z//;
	print "d=$dpart; f=$fpart\n";
	if (! -d "$tdir/$dpart") {
		make_path("${tdir}/${dpart}", {error => \my $err}) ;
			if (@$err) {die "Can't mkdir <${tdir}/${dpart}> $! \n";}
			else { print "no error\n";}
	}
	print "copying $f to $tdir/$dpart/$fpart \n";
	copy("$f", "$tdir/$dpart/$fpart");
}
