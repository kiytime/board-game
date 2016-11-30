use strictures 2;
use feature ':5.14';
use List::Util qw( shuffle );

my $title = 'The Game of Fun';

my $players = [
  { name=>'Ula', score=>0, position=>0 }, #0
  { name=>'Dad', score=>0, position=>0 }, #1
];

my $board = [
  { name=>'Start', points=>0 }, #0
  { name=>'Neighborhood Park', points=>8 }, #1
  { name=>'Grocery Store', points=>1 }, #2
  { name=>'Zoo', points=>5 }, #3
  { name=>'B day Party', points=>2 }, #4
  { name=>'StarBucks', points=>11 }, #5
  { name=>'The Pool', points=>7 }, #6
  { name=>'Powells Books', points=>4 }, #7
  { name=>'BAG DAD', points=>9 }, #8
  { name=>'Flying Cat CO.',points=>6 }, #9
  { name=>'Candy Shop',points=>10 }, #10
  { name=>'Trader Joe\'s',points=>3 }, #11
];

@$players = shuffle @$players;

my $winning_score = 50;

my $player_id = 0;
my $winner_id;

say "Welcome to the $title!";

while (!defined $winner_id) {
  my $player = $players->[ $player_id ];
  say "It is $player->{name}'s turn!";

  say "$player->{name} please press enter to play your turn:";
  my $enter = <STDIN>;

  my $moves = roll_dice();
  say "$player->{name} rolled $moves!";

  my $position = $player->{position};
  while ($moves) {
    $position = $position + 1;
    $moves = $moves - 1;
    $position = 0 if !$board->[ $position ];
  }
  $player->{position} = $position;

  my $square = $board->[$position];
  say "$player->{name} moved to the $square->{name}!";

  if ($square->{points}) {
    $player->{score} = $player->{score} + $square->{points};
    say "$player->{name} gained $square->{points}!";
  }

  say_scores();

  if ($player->{score} >= $winning_score) {
    $winner_id = $player_id;
  }

  $player_id = $player_id + 1;
  $player_id = 0 if !$players->[ $player_id ];
}

my $winner = $players->[ $winner_id ];
say "Player $winner->{name} won the game!";

sub roll_dice {
  return int( rand() * 6 ) + 1;
}

sub say_scores {
  say "Player scores:";
  foreach my $player (@$players) {
    say " - $player->{name}: $player->{score}";
  }
}
