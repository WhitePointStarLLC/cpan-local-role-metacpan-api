package CPAN::Local::Role::MetaCPAN::API;

# ABSTRACT: A role for plugins needing to access or query MetaCPAN's API

use common::sense;

use Moose::Role;
use namespace::autoclean;
use MooseX::AttributeShortcuts;
use Moose::Util::TypeConstraints;

use MetaCPAN::API;

with 'MooseX::RelatedClasses' => {
    name      => 'MetaCPAN::API',
    namespace => undef,
};

=attr metacpan

This attribute contains a read-only, lazily constructed L<MetaCPAN::API>
instance.

=method metacpan

Returns our L<MetaCPAN::API> instance.

=cut

has metacpan => (
    is      => 'lazy',
    isa     => class_type('MetaCPAN::API'),
    builder => sub {
        my $self = shift @_;

        my $v = $self->VERSION // 'dev';
        return $self->meta_cpan__api_class->new(
            ua_args => [
                agent => "CPAN::Local::Role::MetaCPAN::API-$v / ",
            ],
        );
    },
);

!!42;
__END__

=for :stopwords metacpan MetaCPAN's

=head1 SYNOPSIS

    # in your plugin
    with 'CPAN::Local::Role::MetaCPAN::API';

    # and later somewhere...
    my $foo = $self->metacpan->...

=head1 DESCRIPTION

This is a role for L<CPAN::Local> plugins that want to access the MetaCPAN
API, by providing a L</metacpan> attribute granting easy access to a
L<MetaCPAN::API> instance.

=head1 SEE ALSO

MetaCPAN::API

CPAN::Local

=cut
