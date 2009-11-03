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
my $create_uuid = 0;

Getopt::Long::Configure ("bundling");
GetOptions (
            'file|f=s'  => \$file,
            'help|h|?'  => \$print_help,
            'version|v' => \$print_version,
            'create|c'  => \$create_uuid,
#           '' => \$,
#            '' => \$,
           );

sub print_version() {
	print <<VERSION;
$program: version $version

This program is released under GPLv3
Written by Richard Hartmann for Debian and Grml
VERSION
	exit 0;
}

sub print_help() {
	print <<HELP;
Help for $program:

  -h, -?, --help : print this help
  -v, --version  : print version
  -f, --file     : file to read from/write to. Defaults to /etc/hostuuid
  -c, --create   : create & save UUID
HELP
	exit 0;
}

sub create_uuid() {
	my $uuid = find_hostuuid();
	if ($uuid) {
		print STDERR "$program: Found UUID '$uuid' in '$file'. Aborting!\n";
		exit 101;
	} else {
		open (F, ">", "$file") or die "$program: Could not open file: '$file'\: $!\n";
		$uuid = create_UUID_as_string(UUID_V4);
		print "$program\: Stored UUID '$uuid' in file '$file'\n";
		print F "$uuid\n";
		close (F);
		exit 0;
	}
}

sub find_hostuuid() {
#	if ($create_uuid) {return 0 unless -e $file;}
	return 0 unless ((-e $file && $create_uuid) || !$create_uuid);
	open (F, "<", "$file") or die "$program: Could not open file: '$file'\: $!\n";
	while (<F>) {
		if (/([0-9a-z]{8}-([0-9a-z]{4}-){3}[0-9a-z]{12})/i) {
			close (F);
			return $1;
		}
	}
}

sub main() {
	print "\n\nIf anyone knows how to die() when there is no value for -f, tell me!\n\n";
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
