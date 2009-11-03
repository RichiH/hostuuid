#!/usr/bin/perl
# GPLv3
# Richard Hartmann

use strict;
use warnings;

use UUID::Tiny;
use Getopt::Long;
use File::Basename;

my $version = '1.0';
my $program = basename($0);

my $file = '/etc/hostuuid';
my $print_version;
my $print_help;
my $create_uuid;


GetOptions (
            'file|f=s'  => \$file,
            'help|h|?'  => \$print_help,
            'version|v' => \$print_version,
            'create|c'  => \$create_uuid,
#           '' => \$,
#            '' => \$,
           );

sub print_version() {
	print "$program: version $version\n";
	print "\n";
	print "This program is released under GPLv3\n";
	print "Written by Richard Hartmann for Debian and Grml\n";
	exit 0;
}

sub print_help() {
	print "help placeholder\n";
	exit 0;
}

sub create_uuid() {
	my $uuid = find_hostuuid();
	if ($uuid) {
		print STDERR "$program: Found UUID '$uuid' in '$file'. Aborting!\n";
		exit 101;
	} else {
		open (F, ">", "$file") or die "$program: Could not open file: '$file'\: $!\n";
		$uuid = create_UUID_as_string('UUID_V4');
		print "$program\: Stored UUID '$uuid' in file '$file'\n";
		print F "$uuid\n";
		close (F);
		exit 0;
	}
}

sub find_hostuuid() {
	open (F, "<", "$file") or die "$program: Could not open file: '$file'\: $!\n";
	while (<F>) {
		if (/([0-9a-z]{8}-([0-9a-z]{4}-){3}[0-9a-z]{12})/i) {
			close (F);
			return $1;
		}
	}
}

sub main() {
	chomp $file;
	print_version() if $print_version;
	print_help()    if $print_help;
	create_uuid()   if $create_uuid;

	my $uuid = find_hostuuid();
	if ($uuid) {
		print "$uuid\n";
	} else {
		print STDERR "$program: Could not find UUID in '$file'\n";
		exit 100;
}	
}

main();
