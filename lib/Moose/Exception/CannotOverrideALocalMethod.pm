package Moose::Exception::CannotOverrideALocalMethod;
our $VERSION = '2.1803';

use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::Role';

has 'method_name' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub _build_message {
    my $self = shift;
    "Cannot add an override of method '".$self->method_name."' because there is a local version of '".$self->method_name."'";
}

1;
