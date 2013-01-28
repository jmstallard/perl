use Net::DNS::Resolver;
  # Set options in the constructor
  my $res = Net::DNS::Resolver->new(
        nameservers => [qw(10.1.1.128 10.1.2.128)],
        recurse     => 0,
        debug       => 1,
  );

  $packet = $res->query('example.com', 'MX');
$res->print;
 print 'last answer was from: ', $res->answerfrom, "\n";
#$res->tcp_timeout(10);
#    my @zone = $res->axfr('example.com');
#
#    if (@zone) {
#        foreach my $rr (@zone) {
#            $rr->print;
#        }
#    } else {
#        print 'Zone transfer failed: ', $res->errorstring, "\n";
#    }
#
