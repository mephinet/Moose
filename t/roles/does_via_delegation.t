use strict;
use warnings;
use Test::More;

{
    package HttpGet;    # role describing an interface
    use Moose::Role;
    requires 'get';
}

{
    package HasLogger;  # role describing an interface
    use Moose::Role;
    requires qw(warning debug);
}

{
    package UserAgent;
    use Moose;
    with qw( HttpGet ); # declare that we implement this interface
    sub get { 1 };
}

{
    package UberLogger;
    use Moose;
    with qw( HasLogger ); # declare that we implement this interface
    sub warning { 1 };
    sub debug { 1 };
}

{
    package Spider;
    use Moose;
    has ua => (
        is         => 'ro',
        does       => 'HttpGet',
        handles    => 'HttpGet',
        lazy       => 1,
        default    => sub { UserAgent->new },
    );
    has logger => (
        handles    => 'HasLogger',
    );
}

my $woolly = Spider->new;

# Make sure that the Delegated roles show up

ok(
    $woolly->DOES('Spider'),
    'object DOES its own class',
);
ok(
    $woolly->can('get'),
    'object can do this method via delegation',
);
ok(
    $woolly->DOES('HttpGet'),
    'object DOES a role composed by its (lazy) instantiated attribute that has full delegation',
);

ok(
    Spider->can('debug'),
    'class can do this method via delegation',
);

ok(
    Spider->new(logger => UberLogger->new)->DOES('HasLogger'),
    'object DOES a role composed by its (non-lazy) instantiated attribute that has full delegation',
);

ok(
    !Spider->new->DOES('HasLogger'),
    "object DOESn't do a role if the delegating attribute is not instantiated",
);

ok(
    Spider->DOES('Spider'),
    'class DOES itself',
);
ok(
    !Spider->DOES('HttpGet'),
    "class DOESn't do anything via delegations - nothing is instantiated to delegate to",
);

done_testing;
