package TestSSL::lookup;

use strict;
use warnings FATAL => 'all';

use Apache2::RequestRec ();
use Apache2::RequestUtil ();
use Apache2::RequestIO ();
use Apache2::ModSSL ();

use Apache2::Const -compile => qw(OK DECLINED);

sub handler {
  my $r = shift;

  $r->content_type('text/plain');
  my $rc=$r->connection->ssl_var_lookup($r->args);
  $rc="UNDEF" unless( defined $rc );
  $r->print($rc."\n");

  Apache2::Const::OK;
}

1;
