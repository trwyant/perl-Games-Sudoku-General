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

our $VERSION = '0.001';

if ($skip) {
    skip ($skip, 1);
} else {
    add_stopwords (<DATA>);

    all_pod_files_spelling_ok ();
}
__DATA__
Fowler's
Ishigaki
Kenichi
Kulesha
lib
Lite
Mhz
min
O'Neill
OO
Pegg
Sudoku
Wasabi
Wyant
Wyllie
YASudoku
cell's
cubical
latin
quads
square's
sudoku
sudokug
sudokux
trove
