use Test::More;
use strict; use warnings FATAL => 'all';

{ package
    MyStorableObj;
  sub TO_JSON {
    my ($self) = @_;
    +{ foo => $self->foo, bar => $self->bar }
  }
  use Moo; with 'App::vaporcalc::Role::Store';
  has foo => ( is => 'ro', default => sub { 1 } );
  has bar => ( is => 'ro', default => sub { 2 } );
}

my $obj = MyStorableObj->new;

{
  use File::Temp ();
  my $fh = File::Temp->new(UNLINK => 1);
  my $fname = $fh->filename;
  ok $obj->save($fname), 'save ok';
  my $loaded = MyStorableObj->load($fname);
  isa_ok $loaded, 'MyStorableObj';
  ok $loaded->foo == 1 && $loaded->bar == 2, 'loaded obj ok';
}

done_testing
