package main;

use strict;
use warnings;

BEGIN {
    eval {require Test::Spelling};
    $@ and do {
	print "1..0 # skip Test::Spelling not available.\n";
	exit;
    };
    Test::Spelling->import();
}

add_stopwords (<DATA>);

all_pod_files_spelling_ok ();

1;
__DATA__
CPSearch
Fowler's
Guine
Ishigaki
Kenichi
Kulesha
Lite
MSWin
Mhz
O'Neill
OO
Pegg
Quincunx
Samurai
Sudoku
SudokuTk
TkPlayer
Wasabi
Wyant
Wyllie
YASudoku
autocopy
cubical
darwin
latin
lib
min
pbcopy
pbpaste
quads
quincunx
square's
sudoku
sudokug
sudokux
trove
xclip
webcmd
