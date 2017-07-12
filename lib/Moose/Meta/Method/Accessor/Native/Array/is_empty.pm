package Moose::Meta::Method::Accessor::Native::Array::is_empty;
our $VERSION = '2.2007';

use strict;
use warnings;

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Reader';

sub _maximum_arguments { 0 }

sub _return_value {
    my $self = shift;
    my ($slot_access) = @_;

    return '@{ (' . $slot_access . ') } ? 0 : 1';
}

no Moose::Role;

1;
