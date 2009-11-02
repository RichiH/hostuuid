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

sub print_hostuuid() {
	open (F, "< $file") or die "$program\: Could not open file: $file\: $!\n";
	while (<F>) {
		if (/([0-9a-z]{8}-([0-9a-z]{4}-){3}[0-9a-z]{12})/i) {
			print "$1\n";
			close (F);
			exit 0;
		}
	}
	print STDERR "$program\: Could not find UUID in $file\n";
	exit 100;
}

sub main() {
	print_version() if $version;
	print_help()    if $help;

	print "file: $file\n";
	print_hostuuid();
}

main();
