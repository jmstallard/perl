use Getopt::Std;
use Data::Dumper;
use strict;
my %opts;

getopt('fdutd', \%opts);

print Dumper %opts;

print $opts{'f'};
print $opts{'d'};
print $opts{'U'};



sub Main::HELP_MESSAGE () {

	print "This is help\n";
}

sub Main::VERSION_MESSAGE() {
print "version 0.1\n";
} 
