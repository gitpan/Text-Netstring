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
# $Id: Netstring.pm,v 1.4 2003/01/30 20:16:18 james Exp $
#
# See the Text::Netstring man page that was installed with this module for
# information on how to use the module.
#

@ISA = qw(Exporter);
# Items to export into callers namespace by request.
@EXPORT_OK = qw(
	netstring_encode netstring_decode netstring_verify
);

$VERSION = '0.01';


sub netstring_encode {

	my @enc = map {

		length($_) . ":" . $_ . ",";

	} @_;

	wantarray ? @enc : $enc[0];
}

sub netstring_decode {

	my @dec = map {

		# should verify the netstring before using decode
		if (/^\d+:(.*),/) {
			$1;
		} else {
			undef;
		}

	} @_;

	wantarray ? @dec : $dec[0];
}

sub netstring_verify {

	my @ver = map {

		/^(\d+):(.*),$/ and length($2) == $1;

	} @_;

	wantarray ? @ver : $ver[0];
}

1;

__END__

=head1 NAME

Text::Netstring - Perl extension for manipulation of netstrings

=head1 SYNOPSIS

 use Text::Netstring qw(netstring_encode netstring_decode netstring_verify);

 $ns = netstring_encode($text);
 @ns = netstring_encode(@text);

 $text = netstring_decode($ns);
 @text = netstring_decode(@ns);

 $valid = netstring_verify($string);
 @valid = netstring_verify(@string);

=head1 DESCRIPTION

This module is a collection of functions to make use of netstrings in
your perl programs. A C<netstring> is a string encoding used by, at
least, QMTP and QMQP.

=over 4

=item netstring_encode()

TBA

=item netstring_decode()

TBA

=item netstring_verify()

TBA

=back

=head1 NOTES

The format of a netstring is described in http://cr.yp.to/proto/qmtp.txt

=head1 AUTHOR

James Raftery <james@now.ie>.

=cut
