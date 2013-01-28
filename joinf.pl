#! perl -slw
use strict;
use Digest::MD5 qw[md5_hex];

die "$0 file.idx"
	unless @ARGV
	and -e $ARGV[ 0 ];

my( $index, $path ) = @ARGV;
$path = '' unless $path;

open my $idxfh, '<', $index or die "$index : $!";
chomp( my @files = <$idxfh> );
close $idxfh;

my( $outfile, $md5 ) = split ' : ', pop @files;
open my $out, '>:raw', "$path/$outfile" or die "$path/$outfile : $!";

my $fullmd5 = new Digest::MD5;

local $/;
for my $part ( @files ) {
	my( $partfile, $partmd5_1 ) = split ' : ', $part;
	open my $partfh, '<:raw', $partfile or die $!;
	my $in = <$partfh>;
	close $partfh;
	my $partmd5_2 = md5_hex $in;
	warn "Mismatch md5 $part -v- $partmd5_2\n"
		unless $partmd5_1 eq $partmd5_2;
	$fullmd5->add( $in );
	printf $out $in;
}
close $out;

print "File: $outfile reconstructed. The md5s ",
	( $md5 eq $fullmd5->hexdigest ) ? 'match' : 'do not match';
