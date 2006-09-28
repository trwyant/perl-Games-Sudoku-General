#!/usr/local/bin/perl

use strict;
use warnings;

my $skip;
BEGIN {
    eval "use Test::Spelling";
    $@ and do {
	eval "use Test";
	plan (tests => 1);
	$skip = 'Test::Spelling not available';;
    };
}

our $VERSION = '0.001_01';

if ($skip) {
    skip ($skip, 1);
} else {
    add_stopwords (<DATA>);

    all_pod_files_spelling_ok ();
}
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
