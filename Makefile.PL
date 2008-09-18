#!perl

use strict;

exists $ENV{AUTOMATED_TESTING} && $ENV{AUTOMATED_TESTING} and exit 0;

print <<EOM;

This is neither a package nor a module, and it cannot be installed.

Now that you have unpacked the compressed archive, you have access
to the files that are used to create the Configure script, that in
turn is used to build perl5.

Read README for further instructions.

EOM

exit 0
