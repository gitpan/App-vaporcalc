package App::vaporcalc::Recipe;
$App::vaporcalc::Recipe::VERSION = '0.001001';
use Defaults::Modern
  -with_types => [
    'App::vaporcalc::Types',
  ];

use Moo; use MooX::late;

has target_quantity   => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has base_nic_per_ml   => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has base_nic_type     => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

has target_nic_per_ml => (
  required => 1,
  is       => 'ro',
  isa      => Int,
);

has target_pg         => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has target_vg         => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has flavor_percentage => (
  required => 1,
  is       => 'ro',
  isa      => Percentage,
);

has flavor_type       => (
  is      => 'ro',
  isa     => VaporLiquid,
  coerce  => 1,
  builder => sub { 'PG' },
);

has notes             => (
  lazy    => 1,
  is      => 'ro',
  isa     => TypedArray[Str],
  coerce  => 1,
  builder => sub { array_of Str },
);

method BUILD {
  unless ($self->target_vg + $self->target_pg == 100) {
    confess "Expected target_vg + target_pg == 100\n",
      "  target_vg ", $self->target_vg, "\n",
      "  target_pg ", $self->target_pg
  }
}

method TO_JSON {
  +{
    map {; $_ => $self->$_ } qw/
      target_quantity
      base_nic_per_ml
      base_nic_type
      target_nic_per_ml
      target_pg
      target_vg
      flavor_percentage
      flavor_type
      notes
    /
  }
}

with 'App::vaporcalc::Role::Calc',
     'App::vaporcalc::Role::Store',
;

1;

=pod

=for Pod::Coverage BUILD TO_JSON

=head1 NAME

App::vaporcalc::Recipe - An e-liquid recipe

=head1 SYNOPSIS

  use App::vaporcalc::Recipe;

  my $recipe = App::vaporcalc::Recipe->new(
    target_quantity   => 30,   # ml

    base_nic_type     => 'PG', # nicotine base type (VG/PG, default PG)
    base_nic_per_ml   => 100,  # mg/ml (base nicotine concentration)
    target_nic_per_ml => 12,   # mg/ml (target nicotine concentration)

    target_pg         => 65,   # target PG percentage
    target_vg         => 35,   # target VG percentage

    flavor_percentage => 15,   # target flavor percentage
    flavor_type       => 'PG', # flavor base type (VG/PG, default PG)

    notes   => [
      'My recipe',
      '13% flavor',
      '2% ethyl maltol'
    ],
  );

  my $result = $recipe->calc;
  # See App::vaporcalc::Result

=head1 DESCRIPTION

An instance of this class represents an e-liquid recipe that can be calculated
to produce per-ingredient C<ml> quantities via L<App::vaporcalc::Role::Calc>.

See L<App::vaporcalc>, especially L<App::vaporcalc/"WARNING">.

=head2 ATTRIBUTES

=head3 target_quantity

The total target quantity, in C<ml>.

=head3 base_nic_type

The base liquid type of the nicotine solution ('VG' or 'PG').

Defaults to 'PG'.

=head3 base_nic_per_ml

The concentration of the base nicotine solution, in mg/ml.

=head3 target_nic_per_ml

The target nicotine concentration, in mg/ml.

=head3 target_pg

The total percentage of PG.

=head3 target_vg

The total percentage of VG.

=head3 flavor_percentage

The total percentage of flavor extract.

=head3 flavor_type

The base liquid type of the flavor extract ('VG' or 'PG').

Defaults to 'PG'.

=head3 notes

A L<List::Objects::WithUtils::Array> containing an arbitrary number of notes
attached to the recipe.

Can be coerced from a plain C<ARRAY>.

=head2 CONSUMES

L<App::vaporcalc::Role::Calc>

L<App::vaporcalc::Role::Store>

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
