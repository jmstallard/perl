use Net::FTP;
use Getopt::Std;
use strict;
use strict 'vars';
use Data::Dumper;

my $host;
my @fileList ;
my $files;
my $userID;
my $pwd;
my %opts;
my $debugFlag = 0;
our ($opt_x, $opt_y);

getopt('hupfdg',\%opts);

print Dumper %opts;

if ($opts{'h'}) {
	$host = $opts{'h'};
	}
else { print "Error: Invalid host <$host>\n"; usage(); }
if ($opts{'u'}) {
	$userID = $opts{'u'};
	if (! ($userID =~ /\w*/)) {
		print "Invalid userid <$opts{'u'}>, please try again\n";
		exit (1);
		}
	}
else { print "Error: Invalid userID:<$userID>\n"; usage(); }
if ($opts{'p'}) {
	$pwd = $opts{'p'};
	}
else { print "Error: Invalid password:<$pwd>\n"; usage(); }

if ($opts{'f'}) { $files = $opts{'f'}; 
if (! -f $files) { print "File $files does not exist, exiting.\n"; exit (1); } 
	open (IN, "<$files") or die "Can't open file $files, $? \n"; 
	@fileList =  <IN>;
}
elsif ($opts{'d'}) {
	my $dir = $opts{'d'};
	if (! -d $dir) {
		print "Directory $dir does not exist, exiting.\n";
		exit (1);
		}
	chdir($dir);
	@fileList =  `find . -type f`;
	}
if ($opts{'g'}) {
	$debugFlag = $opts{'g'};
	if (! $debugFlag =~ /[0-9]/) {
		print "Error: debug value of $debugFlag invalid, only values from 0-9 acceptable\n";
		}
	}

# Connect to host.
print "fileList=";
print Dumper @fileList;
my $ftp = Net::FTP->new( $host, Debug=>1 ) or die "Can't connect to $host $@\n";
$ftp->login($userID, $pwd) or die "Cannot login using <$userID>", $ftp->message;
$ftp->binary();

foreach my $f (@fileList) {
	chomp($f);
	my $df = $f; 
	$df =~ s/^\.\///;
	$df =~ s/\//Z-Z/g;
	print "Transfer:<$f> to <$df>\n";
	$ftp->put($f, $df);
	}	

$ftp->quit;

sub usage() {
	print "Usage: $0 -h <host> -U <userID> -p <passwd> [-f <file> | -d <dir>] [-g <debugFlag>] \n";
	print "Where:\n";
	print " <host> = domain name or IPv4@ of target host. \n";
	print " <userID> = user account of target host. \n";
	print " <pwd> = password of user account of target host. \n";
	print " <file> = file containing files to transfer, in format <dir>/<file>.... \n";
	print " \t Note:files must be relative to current directory !!! \n";
	print " <dir> = directory containing files to transfer, in format <dir>/<file>.... \n";
	print " <debugFlag> = FTP debug flag value. Defaults to 0 (off), may specify 1 (on). \n";
	die "Please try again.\n";
	}

