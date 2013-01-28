#

sub head {
my $title=shift;

print "<html>\n";
print "<head>\n";
print "<title>$title</title>\n";
print "</head>\n";
print "<body>\n";

}

sub foot {

print "</body>\n";
print "</html>\n";
}

sub hlink {
$fn = shift;
#print "fn=$fn\n";
print "<a href=\"./$fn.htm\">$fn .htm<a>";
}


my $f = $ARGV[0];

head($f);
open (IN, "<$f") or die "can't open $f $! \n";
while ($l = <IN>) {
	if ($l =~ /\w+\.pl/) {
		hlink ($&); 
		print "$'<br>\n";
		}
	else {print "$l<br>\n";}
	}

foot();

