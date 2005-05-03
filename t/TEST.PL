#!perl

use strict;
use warnings FATAL => 'all';

use lib qw(lib);

use Apache::TestRunPerl ();

my $I=Apache::TestRunPerl->new;

my @argv=@ARGV;			# save
$I->run(@ARGV);

@ARGV=@argv;			# restore
Apache::TestConfig::autoconfig_skip_module_add('mod_ssl.c');

$I->refresh;

$I->run(@ARGV);
