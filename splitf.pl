#! perl -slw
use strict;
use Digest::MD5 qw[md5_hex];

my( $file, $size, $path ) = @ARGV;

die "$0 file size [path]"
	unless @ARGV >= 2
	and ( -e $file or print "$file does not exists" )
	and ( not -z $file or print "$file is zero size" )
	and ( $size or print "You must specify a non-zero part size" )
	and ( $size <= -s $file or print "The part size must be < filesize" );

$path = '' unless $path;

#open my $index, '>', "$path/$file.idx"
open(my $index, ">$file.idx")
	or die "$file.idx: $!";
binmode("$index");
local $/ =  \$size;
#open my $data, '< :raw', $file or die "$file : $!";
open ( my $data, "<$file") or die "$file : $!";
binmode(  "$data") or die "$file : $!";

my $n = '00000';
my $fullmd5 = new Digest::MD5;
while( <$data> ) {
	$fullmd5->add( $_ );
	my $partmd5 = md5_hex( $_ );
	open my $part, '>:raw', "$path/$file.$n" or die $!;
	printf $part $_;
	close $part;
	print $index "$file.$n : $partmd5";
	$n++;
}
close $data;

print $index "$file : ", $fullmd5->hexdigest;
close $index;
