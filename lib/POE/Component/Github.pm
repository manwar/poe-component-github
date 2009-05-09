package POE::Component::Github;

use strict;
use warnings;
use POE::Component::Client::HTTP;
use Algorithm::FloodControl;
use vars qw($VERSION);

$VERSION = '0.02';

use MooseX::POE;

has login => (
    is      => 'ro',
    isa     => 'Str',
    default => '',
);

has token => (
    is      => 'ro',
    isa     => 'Str',
    default => '',
);

has url_path => (
    is      => 'ro',
    default => 'github.com/api/v2/json/',
);

has _http_alias => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

sub START {
  my $self = shift;
  $self->_http_alias( join '-', __PACKAGE__, $self->get_session_id );
  $poe_kernel->refcount_increment( $self->get_session_id, __PACKAGE__ );
  POE::Component::Client::HTTP->spawn(
	Alias           => $self->_http_alias,
	FollowRedirects => 2,
  );
  return;
}

event shutdown => sub {
  my ($kernel,$self) = @_[KERNEL,OBJECT];
  $kernel->refcount_decrement( $self->get_session_id, __PACKAGE__ );
  $kernel->post( $self->_http_alias, 'shutdown' );
  return;
};

event user => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

event issues => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

event repos => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

event commits => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

event object => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

event network => sub {
  my ($kernel,$self,$cmd) = @_[KERNEL,OBJECT,ARG0];
  return;
};

no MooseX::POE;

#__PACKAGE__->meta->make_immutable;

'Moooooooooooose!';
__END__
