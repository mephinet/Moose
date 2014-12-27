
use strict;
use warnings;

use Test::More;

use Test::Requires {
    'Test::Pod::Coverage' => '1.04',    # skip all if not installed
};

# This is a stripped down version of all_pod_coverage_ok which lets us
# vary the trustme parameter per module.
my @modules = grep {
    !/Accessor::Native.*$/ && !/::Conflicts$/ && !/^Moose::Exception::/
} all_modules();
plan tests => scalar @modules;

my %trustme = (
    'Moose::Exception' => ['BUILD'],
    'Class::MOP'       => [
        'DEBUG_NO_META',
        'HAVE_ISAREV',
        'IS_RUNNING_ON_5_10',
        'subname',
        'in_global_destruction',
        'check_package_cache_flag',
        'load_first_existing_class',
        'is_class_loaded',
        'load_class',
    ],
    'Class::MOP::Attribute'                           => ['.+'],
    'Class::MOP::Class'                               => ['.+'],
    'Class::MOP::Class::Immutable::Trait'             => ['.+'],
    'Class::MOP::Class::Immutable::Class::MOP::Class' => ['.+'],
    'Class::MOP::Deprecated'                          => ['.+'],
    'Class::MOP::Instance'                            => ['.+'],
    'Class::MOP::Method'                              => ['.+'],
    'Class::MOP::Method::Accessor'                    => ['.+'],
    'Class::MOP::Method::Constructor'                 => ['.+'],
    'Class::MOP::Method::Generated'                   => ['.+'],
    'Class::MOP::Method::Meta'                        => ['.+'],
    'Class::MOP::MiniTrait'                           => ['.+'],
    'Class::MOP::Mixin::AttributeCore'                => ['.+'],
    'Class::MOP::Mixin::HasAttributes'                => ['.+'],
    'Class::MOP::Mixin::HasMethods'                   => ['.+'],
    'Class::MOP::Mixin::HasOverloads'                 => ['.+'],
    'Class::MOP::Overload'                            => ['attach_to_class'],
    'Class::MOP::Package' => [ 'get_method_map', 'wrap_method_body' ],
    'Moose'                  => [ 'init_meta', 'throw_error' ],
    'Moose::Error::Confess'  => ['new'],
    'Moose::Meta::Attribute' => [
        qw( interpolate_class
            throw_error
            attach_to_class
            )
    ],
    'Moose::Meta::Attribute::Native::MethodProvider::Array'   => ['.+'],
    'Moose::Meta::Attribute::Native::MethodProvider::Bool'    => ['.+'],
    'Moose::Meta::Attribute::Native::MethodProvider::Code'    => ['.+'],
    'Moose::Meta::Attribute::Native::MethodProvider::Counter' => ['.+'],
    'Moose::Meta::Attribute::Native::MethodProvider::Hash'    => ['.+'],
    'Moose::Meta::Attribute::Native::MethodProvider::String'  => ['.+'],
    'Moose::Meta::Class'                                      => [
        qw( check_metaclass_compatibility
            construct_instance
            create_error
            raise_error
            reinitialize
            superclasses
            )
    ],
    'Moose::Meta::Class::Immutable::Trait' => ['.+'],
    'Moose::Meta::Method'                  => ['throw_error'],
    'Moose::Meta::Method::Accessor'        => [
        qw( generate_accessor_method
            generate_accessor_method_inline
            generate_clearer_method
            generate_predicate_method
            generate_reader_method
            generate_reader_method_inline
            generate_writer_method
            generate_writer_method_inline
            new
            )
    ],
    'Moose::Meta::Method::Constructor' => [
        qw( attributes
            initialize_body
            meta_instance
            new
            options
            )
    ],
    'Moose::Meta::Method::Destructor' => [ 'initialize_body', 'options' ],
    'Moose::Meta::Method::Meta'       => ['wrap'],
    'Moose::Meta::Role'               => [
        qw( alias_method
            get_method_modifier_list
            reinitialize
            reset_package_cache_flag
            update_package_cache_flag
            wrap_method_body
            )
    ],
    'Moose::Meta::Mixin::AttributeCore' => ['.+'],
    'Moose::Meta::Role::Composite'      => [
        qw( add_method
            get_method
            get_method_list
            has_method
            is_anon
            add_overloaded_operator
            get_all_overloaded_operators
            get_overload_fallback_value
            is_overloaded
            set_overload_fallback_value
            ),
    ],
    'Moose::Object' => [ 'BUILDALL', 'DEMOLISHALL' ],
    'Moose::Role'   => [
        qw( after
            around
            augment
            before
            extends
            has
            inner
            override
            super
            with
            init_meta )
    ],
    'Moose::Meta::TypeCoercion'        => ['compile_type_coercion'],
    'Moose::Meta::TypeCoercion::Union' => ['compile_type_coercion'],
    'Moose::Meta::TypeConstraint' => [qw( compile_type_constraint inlined )],
    'Moose::Meta::TypeConstraint::Class' =>
        [qw( equals is_a_type_of is_a_subtype_of )],
    'Moose::Meta::TypeConstraint::Enum' => [qw( constraint equals )],
    'Moose::Meta::TypeConstraint::DuckType' =>
        [qw( constraint equals get_message )],
    'Moose::Meta::TypeConstraint::Parameterizable' => ['.+'],
    'Moose::Meta::TypeConstraint::Parameterized'   => ['.+'],
    'Moose::Meta::TypeConstraint::Role'  => [qw( equals is_a_type_of )],
    'Moose::Meta::TypeConstraint::Union' => [
        qw( compile_type_constraint
            coercion
            has_coercion
            can_be_inlined
            inline_environment )
    ],
    'Moose::Util'                  => ['add_method_modifier'],
    'Moose::Util::MetaRole'        => ['apply_metaclass_roles'],
    'Moose::Util::TypeConstraints' => ['find_or_create_type_constraint'],
    'Moose::Util::TypeConstraints::Builtins' => ['.+'],
);

for my $module ( sort @modules ) {

    my $trustme = [];
    if ( $trustme{$module} ) {
        my $methods = join '|', @{ $trustme{$module} };
        $trustme = [qr/^(?:$methods)$/];
    }

    pod_coverage_ok(
        $module, { trustme => $trustme },
        "Pod coverage for $module"
    );
}
