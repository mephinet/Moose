package Moose::Exception::Role::InvalidAttributeOptions;
our $VERSION = '2.1903';

use Moose::Role;
with 'Moose::Exception::Role::ParamsHash';

has 'attribute_name' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;
