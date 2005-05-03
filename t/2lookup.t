use strict;
#use warnings FATAL => 'all';

use Apache::Test qw(:withtestmore);
use Test::More;
use Apache::TestUtil;
use Apache::TestRequest 'GET_BODY';

sub ssl_loaded {
  open my $f, "t/conf/httpd.conf" or die "ERROR: Cannot read t/conf/httpd.conf: $!";
  return grep(/^\s*LoadModule\s+ssl_module\b/, <$f>) ? 1 : 0;
}

sub test {
  my $conf=shift;
  my $addr=shift;

  my ($hostport, $res);

  Apache::TestRequest::module($conf);

  # send request
  $hostport = Apache::TestRequest::hostport() || '';
  t_debug("connecting to $hostport");

  return GET_BODY "http".($conf=~'SSL'?'s':'')."://$hostport/TestSSL/".$addr;
}

if( ssl_loaded ) {
  plan tests => 6;

  ok t_cmp( test( 'default', 'lookup?HTTPS' ), "off\n", "HTTPS off" );
  ok t_cmp( test( 'SSL', 'lookup?HTTPS' ), "on\n", "HTTPS on" );
  ok t_cmp( test( 'SSL', 'lookup?SSL_PROTOCOL' ), qr/.+/, "SSL_PROTOCOL" );
  ok t_cmp( test( 'SSL', 'lookup?SSL_SERVER_S_DN' ), '/C=DE/ST=Baden-Wuertemberg/L=Gaiberg/O=Foertsch Consulting/CN=localhost/emailAddress=torsten.foertsch@gmx.net'."\n", "SSL_SERVER_S_DN" );
  ok t_cmp( test( 'SSL', 'lookup?SSL_SERVER_I_DN' ), '/C=DE/ST=Baden-Wuertemberg/L=Gaiberg/O=Foertsch Consulting/OU=CA/CN=Foertsch Consulting CA/emailAddress=torsten.foertsch@gmx.net'."\n", "SSL_SERVER_S_DN" );
  ok t_cmp( test( 'SSL', 'lookup?DUMMY' ), "\n", "DUMMY" );
} else {
  plan tests => 2;

  ok t_cmp( test( 'default', 'lookup?HTTPS' ), "UNDEF\n", "no ssl" );
  ok t_cmp( test( 'default', 'lookup?DUMMY' ), "UNDEF\n", "DUMMY" );
}

# Local Variables: #
# mode: cperl #
# End: #
