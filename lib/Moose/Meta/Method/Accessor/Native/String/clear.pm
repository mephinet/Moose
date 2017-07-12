package Moose::Meta::Method::Accessor::Native::String::clear;
our $VERSION = '2.2007';

use strict;
use warnings;

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Writer';

sub _maximum_arguments { 0 }

sub _potential_value { '""' }

sub _inline_optimized_set_new_value {
    my $self = shift;
    my ($inv, $new, $slot_access) = @_;

    return $slot_access . ' = "";';
}

no Moose::Role;

1;
