use ExtUtils::MakeMaker;
# $Id: Makefile.PL,v 1.3 2003/01/30 18:53:13 james Exp $
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Text::Netstring',
    'VERSION_FROM' => 'Netstring.pm', # finds $VERSION
    'dist'	=> { POSTOP=>'$(CHMOD) 444 $(DISTVNAME).tar$(SUFFIX)' },
);
