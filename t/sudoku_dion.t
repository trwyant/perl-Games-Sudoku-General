
use strict;
use warnings;

use Games::Sudoku::General;
use Test;

my $loc = tell DATA;
my $method;
my $su;
my %variable;
my $number;
my @todo;
my $pass;

new ();

for ($pass = 0; $pass < 2; $pass++) {
    $number = 0;
    %variable = ();
    @todo = ();
    seek (DATA, $loc, 0);
    while (<DATA>) {
	s/^\s+//;
	next unless $_;
	next if m/^#/;
	s/\s+$//;
	my $outside = 1;
	my @args = map {
	    $outside++ % 2 ? (map {
		m/^<<(.+)/ ? do {
		    my $t = $1 . "\n"; my $r = '';
		    while (<DATA>) {last if $_ eq $t; $r .= $_}
		    $r } :
		m/^\$(.+)/ ? $variable{$1} || $1 :
		$_
		} split ('\s+', $_)) :
	    $_} split "'", $_;
	$variable{trace} and
	    print "#> ", join (' ', map {m/\s/ ? "'$_'" : $_} @args), "\n";
	my $verb = shift @args;
	if ($verb =~ m/\W/ || $verb =~ m/^_/) {
	    warn <<eod;
Error - Verb '$verb' is illegal.
eod
	    }
	  elsif (__PACKAGE__->can ($verb)) {
	    __PACKAGE__->$verb (@args);
	    }
	  elsif ($su->can ($verb)) {
	    next unless $pass;
	    $method = $verb;
	    $variable{result} = eval {$su->$verb (@args)} || $@ || '';
	    warn $@ if $@;
	    }
	  else {
	    warn <<eod;
Error - Verb '$verb' is unknown.
eod
	    }
	}


    unless ($pass) {plan tests => $number, todo => \@todo; }

    }

#	echo prints its arguments.

sub echo {
return unless $pass;
shift;
foreach (@_) {
    chomp;
    foreach (split '\n', $_) {
	s/^\.//;
	print "#         ", ' ' x length ($number), "$_\n" if $_
	}
    }
}

#	fowler translates Glenn Fowler's cell numbers into mine.

sub fowler {
$variable{result} = $_[1];
$variable{result} =~
    s/\[(\d+),(\d+)\]/'[' . (($1 - 1) * 9 + $2 - 1) . ']'/gem;
}

#	new instantiates a new Games::Sudoku::General object.

sub new {shift; $su = Games::Sudoku::General->new (@_)}

#	test compares the previous result to its first argument. It
#	also prints some front matter for the test, with the second
#	argument being the title (defaulting to the name of the
#	previous method), and subsequent arguments being echoed.

sub test {
shift;
$number++;
return unless $pass;
my $expect = shift;
chomp $expect;
my $title = shift || $method;
chomp $title;
print <<eod;
#
# Test $number - $title
eod
__PACKAGE__->echo (@_) if @_;
my $result = $variable{result};
chomp $result;
if ($result =~ m/\n/ || $expect =~ m/\n/) {
    foreach ([Expect => $expect], [Got => $result]) {
	printf "# %9s:\n", $_->[0];
	foreach (split '\n', $_->[1]) {print "#          $_\n"}
	}
    }
  else {
    print <<eod;
#    Expect: $expect
#       Got: $result
eod
    }
ok ($expect eq $result);
}

#	todo marks the previous test as a 'todo' item.

sub todo {push @todo, $number}

sub unload {$variable{result} = $su->_unload () if $pass}

#	var defines a pseudo-lexical variable, which can be substituted
#	into the command by prefixing the variable name with a '$'.
#	Note that $result is implicitly set by any
#	Games::Sudoku::General method.

sub var {shift; my $name = shift; $variable{$name} = "@_"}

__END__

set cube 3
problem <<eod
. . . . 3 . . . .
. 9 . . 4 . . 8 .
. . . . . . . . .
. . . . . . . . .
7 3 . . 1 . . 5 4
. . . . . . . . .
. . . . . . . . .
. 2 . . 7 . . 6 .
. . . . 5 . . . .

3 . . . 9 . . . 2
. . . . 7 . . . .
. . 9 2 . 4 7 . .
. . 4 7 . 8 6 . .
1 9 . . . . . 8 7
. . 3 9 . 1 4 . .
. . 1 4 . 5 8 . .
. . . . 1 . . . .
5 . . . 8 . . . 6

. . . 4 . 5 . . .
. 3 . 6 . 9 . 5 .
. . . . . . . . .
3 8 . . . . . 4 2
. . . . 7 . . . .
6 1 . . . . . 3 8
. . . . . . . . .
. 9 . 5 . 2 . 8 .
. . . 9 . 1 . . .

. . 6 . . . 3 . .
. . . . . . . . .
2 . 4 . . . 6 . 9
. . . . . . . . .
. . . . . . . . .
. . . . . . . . .
4 . 5 . . . 9 . 1
. . . . . . . . .
. . 7 . . . 5 . .

4 2 . . 7 . . 6 1
6 1 . . . . . 3 8
. . . . 9 . . . .
. . . . . . . . .
8 . 3 . 6 . 4 . 5
. . . . . . . . .
. . . . 1 . . . .
5 4 . . . . . 9 6
9 6 . . 2 . . 7 3

. . 8 . . . 2 . .
. . . . . . . . .
9 . 1 . . . 8 . 3
. . . . . . . . .
. . . . . . . . .
. . . . . . . . .
1 . 6 . . . 3 . 7
. . . . . . . . .
. . 4 . . . 6 . .

. . . 9 . 1 . . .
. 5 . 7 . 8 . 1 .
. . . . . . . . .
5 4 . . . . . 9 6
. . . . 2 . . . .
7 3 . . . . . 5 4
. . . . . . . . .
. 8 . 1 . 6 . 4 .
. . . 8 . 3 . . .

6 . . . 5 . . . 8
. . . . 9 . . . .
. . 5 8 . 3 9 . .
. . 3 9 . 1 4 . .
2 5 . . . . . 1 9
. . 6 5 . 2 3 . .
. . 2 3 . 7 1 . .
. . . . 2 . . . .
7 . . . 1 . . . 4

. . . . 8 . . . .
. 6 . . 2 . . 7 .
. . . . . . . . .
. . . . . . . . .
3 8 . . 9 . . 4 2
. . . . . . . . .
. . . . . . . . .
. 5 . . 3 . . 1 .
. . . . 4 . . . .
eod
solution
test <<eod 'Dion Cube 1' 'http://www.sudoku.org.uk/'
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5
9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6
3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8

3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5
9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6

9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6
3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5

1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9
7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3
4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2

4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2
1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9
7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3

7 3 8 6 1 9 2 5 4
5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3
4 2 5 8 7 3 9 6 1
6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2
1 9 6 5 4 2 3 8 7
8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9

8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4
6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1

6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1
8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4

5 4 2 3 8 7 1 9 6
9 6 1 4 2 5 8 7 3
7 3 8 6 1 9 2 5 4
6 1 9 2 5 4 7 3 8
3 8 7 1 9 6 5 4 2
4 2 5 8 7 3 9 6 1
8 7 3 9 6 1 4 2 5
2 5 4 7 3 8 6 1 9
1 9 6 5 4 2 3 8 7
eod

