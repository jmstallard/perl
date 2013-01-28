  #!/usr/bin/perl
    use strict;
    use warnings;
    use LWP::Simple;

    #my $content = get('http://www.perlmeme.org') or die 'Unable to get page';
    my $content = get('http://www.doesnotexist.abc') or die 'Unable to get page';
	
	print "content=$content\n";
    exit 0;
