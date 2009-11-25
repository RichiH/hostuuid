use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'hostuuid',
    AUTHOR              => q{Richard Hartmann <richih.mailinglist@gmail.com>},
    VERSION_FROM        => 'hostuuid',
    ABSTRACT_FROM       => 'hostuuid',
    INST_BIN            => '/usr/bin',
    INST_MAN1DIR        => '/usr/share/man/man1',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'gpl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM           => {},
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'hostuuid-*' },
);
