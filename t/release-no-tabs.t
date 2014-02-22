
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'bin/vaporcalc',
    'lib/App/vaporcalc.pm',
    'lib/App/vaporcalc/Cmd/Result.pm',
    'lib/App/vaporcalc/Cmd/Subject/Flavor.pm',
    'lib/App/vaporcalc/Cmd/Subject/Help.pm',
    'lib/App/vaporcalc/Cmd/Subject/NicBase.pm',
    'lib/App/vaporcalc/Cmd/Subject/NicTarget.pm',
    'lib/App/vaporcalc/Cmd/Subject/NicType.pm',
    'lib/App/vaporcalc/Cmd/Subject/Notes.pm',
    'lib/App/vaporcalc/Cmd/Subject/Pg.pm',
    'lib/App/vaporcalc/Cmd/Subject/Recipe.pm',
    'lib/App/vaporcalc/Cmd/Subject/TargetAmount.pm',
    'lib/App/vaporcalc/Cmd/Subject/Vg.pm',
    'lib/App/vaporcalc/CmdEngine.pm',
    'lib/App/vaporcalc/Exception.pm',
    'lib/App/vaporcalc/Flavor.pm',
    'lib/App/vaporcalc/FormatString.pm',
    'lib/App/vaporcalc/Recipe.pm',
    'lib/App/vaporcalc/RecipeResultSet.pm',
    'lib/App/vaporcalc/Result.pm',
    'lib/App/vaporcalc/Role/Calc.pm',
    'lib/App/vaporcalc/Role/Store.pm',
    'lib/App/vaporcalc/Role/UI/Cmd.pm',
    'lib/App/vaporcalc/Role/UI/ParseCmd.pm',
    'lib/App/vaporcalc/Role/UI/PrepareCmd.pm',
    'lib/App/vaporcalc/Types.pm'
);

notabs_ok($_) foreach @files;
done_testing;
