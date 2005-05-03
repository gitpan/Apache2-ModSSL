#!perl

use 5.008;
use ModPerl::MM ();
use Apache::TestMM qw(test clean);

# accept the configs from command line
Apache::TestMM::filter_args();
Apache::TestMM::generate_script('t/TEST');

ModPerl::MM::WriteMakefile(
  NAME          => 'Apache2::ModSSL',
  VERSION_FROM  => 'lib/Apache2/ModSSL.pm',
  PREREQ_PM     => { mod_perl2   => 0 },
  dist          => {
		    PREOP => './mk_README.sh',
		   },
  clean         => {
		    FILES=>"t/TEST",
		   },
);

sub MY::postamble {
  return <<'EOF';
README: lib/Apache2/ModSSL.pm mk_README.sh
	./mk_README.sh
EOF
}
