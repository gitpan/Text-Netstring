package Text::Netstring;

use strict;
use vars qw($VERSION @ISA @EXPORT_OK);

require Exporter;

#
# Copyright (c) 2003 James Raftery <james@now.ie>. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
# Please submit bug reports, patches and comments to the author.
# Latest information at http://romana.now.ie/
#
# $Id: Netstring.pm,v 1.8 2003/06/12 17:10:29 james Exp $
#
# See the Text::Netstring man page that was installed with this module for
# information on how to use the module.
#

@ISA = qw(Exporter);
# Items to export into callers namespace by request.
@EXPORT_OK = qw(
	netstring_encode netstring_decode netstring_verify
);

$VERSION = '0.03';


sub netstring_encode {

	# is argument a list reference?
	if (scalar @_ == 1 and ref $_[0] eq "ARRAY") {
		@_ = @{ $_[0] };
	}

	my @enc = map {

		length($_) . ":" . $_ . ",";

	} @_;

	wantarray ? @enc : join("", @enc);
}

sub netstring_decode {

	# is argument a list reference?
	if (scalar @_ == 1 and ref $_[0] eq "ARRAY") {
		@_ = @{ $_[0] };
	}

	my @dec = map {

		# should verify the netstring before using decode
		if (/^\d+:(.*),/) {
			$1;
		} else {
			"";
		}

	} @_;

	wantarray ? @dec : join("", @dec);
}

sub netstring_verify {

	# is argument a list reference?
	if (scalar @_ == 1 and ref $_[0] eq "ARRAY") {
		@_ = @{ $_[0] };
	}

	my @ver = map {

		/^(\d+):(.*),$/ and length($2) == $1;

	} @_;

	wantarray ? @ver : $ver[0];
}

1;

__END__

=head1 NAME

Text::Netstring - Perl module for manipulation of netstrings

=head1 SYNOPSIS

 use Text::Netstring qw(netstring_encode netstring_decode netstring_verify);

 $ns = netstring_encode($text);
 @ns = netstring_encode(@text);
 $ns = netstring_encode(@text);

 $text = netstring_decode($ns);
 @text = netstring_decode(@ns);
 $text = netstring_decode(@ns);

 $valid = netstring_verify($string);
 @valid = netstring_verify(@string);

=head1 DESCRIPTION

This module is a collection of functions to make use of netstrings in
your perl programs. A I<netstring> is a string encoding used by, at
least, QMTP and QMQP.

=over 4

=item netstring_encode()

Encode the argument string, list of strings, or referenced list of
string as a netstring.

Supplying a scalar argument in a scalar context or list or list
reference argument in list context does what you'd expect; encoding the
scalar or each element of the list, as appropriate. Supplying a list or
list reference argument in a scalar context, however, returns a single
scalar which is the concatenation of each element of the list encoded as
a netstring.

=item netstring_decode()

Decode the argument netstring, list of netstrings, or referenced list of
netstrings returning the I<interpretation> of each.

The same context handling as for netstring_encode() applies.

=item netstring_verify()

Check the validity of the supplied netstring, or list of netstrings.
Returns a C<TRUE> or C<FALSE> value, or list of same, as appropriate.
Supplying a list argument in a scalar context will return a value for
the first element of the list only.

=back

=head1 EXAMPLES

 use Text::Netstring qw(netstring_encode);

 @s = ("foo", "bar");
 $t = netstring_encode( scalar netstring_encode(@s) );

C<12:3:foo,3:bar,,> is the value of C<$t>

 $s = ["5:whizz," , "4:bang,"];
 $t = netstring_decode($s);

C<whizzbang> is the value of C<$t>

=head1 NOTES

The format of a netstring is described in http://cr.yp.to/proto/qmtp.txt

=head1 AUTHOR

James Raftery <james@now.ie>.

=cut
