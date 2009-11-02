#!/usr/bin/perl
# GPLv3
# Richard Hartmann

use strict;
use warnings;

use File::Basename;
use Getopt::Long;

my $version = '1.0';
my $program = basename($0);

my $file = '/etc/hostuuid';
my $help = $version = 0;


GetOptions (
            'file|f=s' => \$file,
            'help|h|?' => \$help,
            'version|v' => \$version,
#            '' => \$,
#           '' => \$,
#            '' => \$,
           );

sub print_version() {
	print "$program : version $version\n";
	exit 0;
}

sub print_help() {
	print "help placeholder\n";
	exit 0;
}

sub main() {
	print_version() if $version;
	print_help()    if $help;

	print "file: $file\n";
}

main();
