package App::vaporcalc::Cmd::Subject::NicTarget;
$App::vaporcalc::Cmd::Subject::NicTarget::VERSION = '0.001001';
use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+verb' => (
  builder => sub { 'show' },
);

method _action_show { $self->_action_view }
method _action_view {
  my $ntarget = $self->recipe->target_nic_per_ml;
  " -> Target nicotine: $ntarget mg/ml"
}

method _action_set {
  my $newnic = $self->params->get(0);
  $self->throw_exception(
    message => 'set requires a parameter'
  ) unless defined $newnic;

  $self->munge_recipe(
    target_nic_per_ml => $newnic,
  )
}

1;
