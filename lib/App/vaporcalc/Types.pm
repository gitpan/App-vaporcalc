package App::vaporcalc::Types;
$App::vaporcalc::Types::VERSION = '0.001002';
use strict; use warnings FATAL => 'all';

use Type::Library   -base;
use Types::Standard -types;
use Type::Utils     -all;


# Numbers

declare Percentage =>
  as Int(),
  where { $_ > -1 && $_ <= 100 };


declare RoundedResult =>
  as StrictNum(),
  where { "$_" =~ /^[0-9]+(\.[0-9])?\z/ };

coerce RoundedResult =>
  from StrictNum(),
  via { sprintf '%.1f', $_ };


# Objects
declare AppException =>
  as InstanceOf['App::vaporcalc::Exception'];

coerce AppException =>
  from Str(),
  via {
    require App::vaporcalc::Exception;
    App::vaporcalc::Exception->new(message => $_)
  };


declare RecipeObject =>
  as InstanceOf['App::vaporcalc::Recipe'];

coerce RecipeObject =>
  from HashRef(),
  via {
    require App::vaporcalc::Recipe;
    App::vaporcalc::Recipe->new(%$_)
  };


declare ResultObject =>
  as InstanceOf['App::vaporcalc::Result'];

coerce ResultObject =>
  from HashRef(),
  via {
    require App::vaporcalc::Result;
    App::vaporcalc::Result->new(%$_)
  };


declare RecipeResultSet =>
  as InstanceOf['App::vaporcalc::RecipeResultSet'];

# Strings

declare VaporLiquid =>
  as Str(),
  where { $_ eq 'PG' or $_ eq 'VG' };

coerce VaporLiquid =>
  from Str(),
  via { uc $_ };


1;

=pod

=head1 NAME

App::vaporcalc::Types

=head1 SYNOPSIS

  use App::vaporcalc::Types -all;

=head1 DESCRIPTION

A set of L<Type::Tiny> types intended for internal use by L<App::vaporcalc>.

=head2 Numeric types

=head3 Percentage

An integer between 0 and 100.

=head3 RoundedResult

A number formatted to one decimal point (C<'%.1f'>).

Can be coerced from a C<StrictNum>.

=head2 Object types

=head3 AppException

An L<App::vaporcalc::Exception> instance.

Can be coerced from a C<Str>.

=head3 RecipeObject

An L<App::vaporcalc::Recipe> instance.

Can be coerced from a C<HashRef>.

=head3 ResultObject

An L<App::vaporcalc::Result> instance.

Can be coerced from a C<HashRef>.

=head3 RecipeResultSet

An L<App::vaporcalc::RecipeResultSet> instance.

=head2 Stringy types

=head3 VaporLiquid

A valid base liquid type (B<PG> or B<VG>).

Can be coerced from a lowercase string.

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

=cut
