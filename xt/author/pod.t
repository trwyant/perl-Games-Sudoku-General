package main;

use strict;
use warnings;

BEGIN {
    eval {
	require Test::More;
	Test::More->import();
	1;
    } or do {
	print <<'EOD';
1..0 # skip Test::More required to test POD validity.
EOD
	exit;
    };
    eval {
	require Test::Pod;
	Test::Pod->VERSION (1.00);
	Test::Pod->import();
	1;
    } or do {
	print <<'EOD';
1..0 # skip Test::Pod 1.00 or higher required to test POD validity.
EOD
	exit;
    };
}

all_pod_files_ok ();

1;
