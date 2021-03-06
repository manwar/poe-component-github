use strict;
use warnings;
use POE qw(Component::Github);

my $user = 'bingos';

my $github = POE::Component::Github->spawn();

POE::Session->create(
  package_states => [
	'main' => [qw(_start _github)],
  ],
);

$poe_kernel->run();
exit 0;

sub _start {
  $poe_kernel->post( $github->get_session_id, 'user', 'show', { event => '_github', user => $user }, );
  return;
}

sub _github {
  my ($kernel,$heap,$resp) = @_[KERNEL,HEAP,ARG0];
  use Data::Dumper;
  warn Dumper($resp);
  $github->yield( 'shutdown' );
  return;
}
