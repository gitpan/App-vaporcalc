package App::vaporcalc::Cmd::Subject::Flavor;
$App::vaporcalc::Cmd::Subject::Flavor::VERSION = '0.001004';
use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method _action_show { $self->_action_view }
method _action_view {
  my $flv = $self->recipe->flavor_percentage;
  " -> Flavor total: $flv %"
}

method _action_set {
  my $newflv = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $newflv;

  $self->munge_recipe(
    flavor_percentage => $newflv
  )
}

1;
