use strict;
use warnings;

BEGIN {
    eval "use Test::Spelling";
    $@ and do {
	print "1..0 # skip Test::Spelling not available.\n";
	exit;
    };
}

our $VERSION = '0.002_01';

add_stopwords (<DATA>);

all_pod_files_spelling_ok ();
__DATA__
autocopy
cell's
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
square's
Sudoku
sudoku
sudokug
SudokuTk
sudokux
trove
Wasabi
Wyant
Wyllie
xclip
YASudoku
