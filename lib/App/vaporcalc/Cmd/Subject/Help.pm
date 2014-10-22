package App::vaporcalc::Cmd::Subject::Help;
$App::vaporcalc::Cmd::Subject::Help::VERSION = '0.001002';
use Defaults::Modern;

use Moo; use MooX::late;
with 'App::vaporcalc::Role::UI::Cmd';

has '+recipe' => (
  isa     => Any,
);

has '+verb' => (
  builder => sub { 'show' },
);

method _action_view { $self->_action_show }
method _action_show {
  my $topic = $self->params->get(0);
  unless ($topic) {
    return join "\n",
      "Commands can be entered as:",
      " [ <VERB> <SUBJECT> <PARAM> ] or [ <SUBJECT> <VERB> <PARAM> ]",
      " e.g.:  set nic base 100",
      "(Without a verb, most subjects will call 'show')",
      " recipe <view/save [PATH]/load [PATH]>",
      " target amount <view/set [ml]>",
      " flavor <view/set [% of total]>", 
      " flavor type <view/set [PG/VG]>",
      " nic base <view/set [mg/ml]>",
      " nic target <view/set [mg/ml]>", 
      " nic type <view/set [PG/VG]>",
      " pg <view/set [% of total]>",
      " vg <view/set [% of total]>",
      " notes <view/clear/add [STR]/del [IDX]>"
  }

  # FIXME
  # Not using currently, better if we dispatch to individual cmds:
  my $meth = '_help_'.$topic;
  if ($self->can($meth)) {
    return $self->$meth
  }
  
  "No help found for '$topic'"
}

1;
