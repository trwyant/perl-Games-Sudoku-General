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

our $VERSION = '0.003_01';

add_stopwords (<DATA>);

all_pod_files_spelling_ok ();
__DATA__
autocopy
cell's
CPSearch
cubical
darwin
Fowler's
Guine
Ishigaki
Kenichi
Kulesha
latin
lib
Lite
Mhz
min
MacOS
MSWin
O'Neill
OO
pbcopy
pbpaste
Pegg
quads
quincunx
samurai
square's
Sudoku
sudoku
sudokug
SudokuTk
sudokux
TkPlayer
trove
Wasabi
webcmd
Wyant
Wyllie
xclip
YASudoku
