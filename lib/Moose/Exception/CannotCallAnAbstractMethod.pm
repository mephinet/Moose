package Moose::Exception::CannotCallAnAbstractMethod;
our $VERSION = '2.1704';

use Moose;
extends 'Moose::Exception';

sub _build_message {
    "Abstract method";
}

1;
