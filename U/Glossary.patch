*** Glossary.orig	Sat Jun  8 19:33:14 2002
--- Glossary	Sat Jun  8 19:33:28 2002
***************
*** 3294,3300 ****
  	make_set_make='#'		# If your make program handles this for you,
  	make_set_make="MAKE=$make"	# if it doesn't.
  	I used a comment character so that we can distinguish a
! 	'set' value (from a previous config.sh or Configure -D option)
  	from an uncomputed value.
  
  mallocobj (mallocsrc.U):
--- 3294,3300 ----
  	make_set_make='#'		# If your make program handles this for you,
  	make_set_make="MAKE=$make"	# if it doesn't.
  	I used a comment character so that we can distinguish a
! 	'set' value (from a previous config.sh or Configure '-D' option)
  	from an uncomputed value.
  
  mallocobj (mallocsrc.U):
***************
*** 3403,3409 ****
  	whole thing is then lower-cased.
  
  n (n.U):
! 	This variable contains the -n flag if that is what causes the echo
  	command to suppress newline.  Otherwise it is null.  Correct usage is
  	$echo $n "prompt for a question: $c".
  
--- 3403,3409 ----
  	whole thing is then lower-cased.
  
  n (n.U):
! 	This variable contains the '-n' flag if that is what causes the echo
  	command to suppress newline.  Otherwise it is null.  Correct usage is
  	$echo $n "prompt for a question: $c".
  
***************
*** 3866,3874 ****
  	/bin/sh, though it's possible that some systems will have /bin/ksh,
  	/bin/pdksh, /bin/ash, /bin/bash, or even something such as
  	D:/bin/sh.exe.
! 	This unit comes before Options.U, so you can't set sh with a -D
  	option, though you can override this (and startsh)
! 	with -O -Dsh=/bin/whatever -Dstartsh=whatever
  
  shar (Loc.U):
  	This variable is defined but not used by Configure.
--- 3866,3874 ----
  	/bin/sh, though it's possible that some systems will have /bin/ksh,
  	/bin/pdksh, /bin/ash, /bin/bash, or even something such as
  	D:/bin/sh.exe.
! 	This unit comes before Options.U, so you can't set sh with a '-D'
  	option, though you can override this (and startsh)
! 	with '-O -Dsh=/bin/whatever -Dstartsh=whatever'
  
  shar (Loc.U):
  	This variable is defined but not used by Configure.
***************
*** 4044,4050 ****
  
  spitshell (spitshell.U):
  	This variable contains the command necessary to spit out a runnable
! 	shell on this system.  It is either cat or a grep -v for # comments.
  
  sPRId64 (quadfio.U):
  	This variable, if defined, contains the string used by stdio to
--- 4044,4050 ----
  
  spitshell (spitshell.U):
  	This variable contains the command necessary to spit out a runnable
! 	shell on this system.  It is either cat or a grep '-v' for # comments.
  
  sPRId64 (quadfio.U):
  	This variable, if defined, contains the string used by stdio to
