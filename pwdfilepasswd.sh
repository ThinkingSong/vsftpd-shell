#!/bin/sh

#################################
#  add pwdfile ftp user record  #
#################################

export user=$1
export passwd=$2

#perl -e '$salt=q($1$).int(rand(1e8)); print "password: "; chomp($passwd=<STDIN>); print crypt($passwd,$salt),"\n"'
perl -e '$salt=q($1$).int(rand(1e8)); print $ENV{"user"},":",crypt($ENV{"passwd"},$salt),"\n"'
