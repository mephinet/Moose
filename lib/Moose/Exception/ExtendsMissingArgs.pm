package Moose::Exception::ExtendsMissingArgs;
our $VERSION = '2.2004';

use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::Class';

sub _build_message {
    "Must derive at least one class";
}

1;
