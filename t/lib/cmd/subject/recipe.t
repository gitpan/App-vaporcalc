use Test::More;
use strict; use warnings FATAL => 'all';

use App::vaporcalc::Cmd::Subject::Recipe;
use App::vaporcalc::Recipe;

my $recipe = App::vaporcalc::Recipe->new(
  target_quantity   => 30,
  base_nic_per_ml   => 36,
  target_nic_per_ml => 12,
  target_pg         => 65,
  target_vg         => 35,
  flavor_percentage => 20,
);

my $cmd = App::vaporcalc::Cmd::Subject::Recipe->new(
  recipe => $recipe
);

ok $cmd->does('App::vaporcalc::Role::UI::Cmd'),
  'does Role::UI::Cmd';

ok $cmd->verb eq 'show', 'default verb ok';
isa_ok $cmd->execute, 'App::vaporcalc::RecipeResultSet',
  'show returns RecipeResultSet';

use File::Temp ();
subtest 'storage' => sub {
  if ($^O eq 'MSWin32') {
    plan skip_all => 'Temp files fail on some Windows platforms'
  }
  my $fh = File::Temp->new(UNLINK => 1);
  my $fname = $fh->filename;

  $cmd = App::vaporcalc::Cmd::Subject::Recipe->new(
    recipe => $recipe,
    verb   => 'save',
    params => [ $fname ],
  );
  like $cmd->execute, qr/$fname/, 'save ok';
  $cmd = App::vaporcalc::Cmd::Subject::Recipe->new(
    recipe => $recipe,
    verb   => 'load',
    params => [ $fname ],
  );
  my $new = $cmd->execute;
  isa_ok $new, 'App::vaporcalc::Recipe';
  ok $new->target_pg == 65, 'loaded recipe looks ok';
};

done_testing