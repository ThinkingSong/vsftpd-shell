perl -e '$salt=q($1$).int(rand(1e8)); print "password: "; chomp($passwd=<STDIN>); print crypt($passwd,$salt),"\n"'
