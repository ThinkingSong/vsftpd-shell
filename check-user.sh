#!/bin/sh

###############################
#  check user for ftp server  #
###############################

DB_HOME=/etc
FILE_HOME=/etc/vsftpd_user_conf

if [ "$#" -ne "1" ]; then
	echo "****************************************************************"
	echo "Usage: sudo sh $0 [argument]"
	echo "Please input the username argument."
	echo "****************************************************************"
	exit 1;
else
	USERBANE="$1"
fi

for user in $USERBANE
do
	LD=`id "$user" 2> /dev/null`;
	if [ "$?" = "0" ]; then
		echo "***Error***: LDAP-User $user exist.";
		echo "$LD";
	fi

	if [ -e $DB_HOME/vsftpd_login.db ]; then
		OLD=`db4.8_dump -d a $DB_HOME/vsftpd_login.db | grep "\[\?\?[0 2 4 6 8]\].*len.*data: $user$" | awk -F: '{print $3}'`;
	fi
        #if [ $OLD = $user ]; then
        #        echo "Error: DB-User $user exist.";
        #fi
	if [ "$OLD" != "" ]; then
		echo "***Error***: DB-User $user exist.";
		db4.8_dump -d a $DB_HOME/vsftpd_login.db | grep -A 1 "\[\?\?[0 2 4 6 8]\].*len.*data: $user$";
	fi

	if [ -e $DB_HOME/vsftpduser ]; then
		OLD_FILE=`cat $DB_HOME/vsftpduser | grep "^$user:" |awk -F ":" '{print $1}'`;
	fi
	if [ "$OLD_FILE" != "" ]; then
		echo "***Error***: FILE-DB-User $user exist.";
		cat $DB_HOME/vsftpduser | grep "^$user:";
	fi

	if [ -e "$FILE_HOME/$user" ]; then
		echo "***Error***: File $FILE_HOME/$user exist.";
                #ls -l $FILE_HOME/$user;
		cat $FILE_HOME/"$user";
	fi

	if [ "$LD" != "" -o "$OLD" != "" -o "$OLD_FILE" != "" -o -e "$FILE_HOME/$user" ]; then
		echo "\n...................... Please check it! ......................\n";
	else
		echo "\n...................... No this user: $user! .....................\n"
        fi
done
