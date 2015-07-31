package Moose::Exception::CannotRegisterUnnamedTypeConstraint;
our $VERSION = '2.1601';

use Moose;
extends 'Moose::Exception';

sub _build_message {
    "can't register an unnamed type constraint";
}

1;
