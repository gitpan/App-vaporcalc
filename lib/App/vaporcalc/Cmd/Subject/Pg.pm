package App::vaporcalc::Cmd::Subject::Pg;
$App::vaporcalc::Cmd::Subject::Pg::VERSION = '0.003001';
use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';


has '+verb' => (
  builder => sub { 'show' },
);


method _action_show { $self->_action_view }
method _action_view {
  my $pg = $self->recipe->target_pg;
  $self->create_result(
    string => " -> PG: $pg %"
  )
}

method _action_set {
  my $new_pg = $self->params->get(0);
  $self->throw_exception(
    message => "set requires a parameter"
  ) unless defined $new_pg;

  my $new_vg = 100 - $new_pg;

  my $recipe = $self->munge_recipe(
    target_pg => $new_pg,
    target_vg => $new_vg
  );
  $self->create_result(
    recipe => $recipe
  )
}


1;
