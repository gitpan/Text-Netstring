# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'
# $Id: netstring.t,v 1.3 2003/02/01 21:26:37 james Exp $

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..7\n"; }
END {print "not ok 1\n" unless $loaded;}
use Text::Netstring qw(netstring_encode netstring_decode netstring_verify);
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $string;


#
# test 2; encode a string into a netstring
# bing-bang-a-bang  should become  16:bing-bang-a-bang,
#
$string = netstring_encode("bing-bang-a-bang");
if ($string eq "16:bing-bang-a-bang,") {
	print "ok 2\n";
} else {
	print "not ok 2\n";
}


#
# test 3; verify a valid netstring
# the result of above should verify as a netstring
#
if (netstring_verify($string)) {
	print "ok 3\n";
} else {
	print "not ok 3\n";
}


#
# test 4; verify invalid netstrings
#
CASE: {
	netstring_verify("bing-bang-a-bang") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify(":bing-bang-a-bang") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify(":bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("15:bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("17:bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("1:bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("0:bing-bang-a-bang,") &&
			do { print "not ok 4\n"; last CASE };
	netstring_verify("16:bing-bang-a-bang") &&
			do { print "not ok 4\n"; last CASE };
		
	print "ok 4\n";
}


#
# test 5; decode a valid netstring
# the result of 2 should decode as  bing-bang-a-bang
#
$string = netstring_decode($string);
if ($string eq "bing-bang-a-bang") {
	print "ok 5\n";
} else {
	print "not ok 5\n";
}


#
# test 6; decode another valid netstring
# 0:,  should decode to an empty string
#
$string = netstring_decode("0:,");
if ($string eq "") {
	print "ok 6\n";
} else {
	print "not ok 6\n";
}


#
# test 7; decode an invalid netstring
# decode of  bing-bang-a-bang  should fail
#
$string = netstring_decode("bing-bang-a-bang");
if (!$string) {
	print "ok 7\n";
} else {
	print "not ok 7\n";
}
