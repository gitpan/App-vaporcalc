package App::vaporcalc::Cmd::Subject::NicBase;
$App::vaporcalc::Cmd::Subject::NicBase::VERSION = '0.001003';
use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method _action_show { $self->_action_view }
method _action_view {
  my $nbase = $self->recipe->base_nic_per_ml;
  " -> Nic base: $nbase mg/ml"
}

method _action_set {
  my $newbase = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $newbase;

  $self->munge_recipe(
    base_nic_per_ml => $newbase
  )
}

1;
