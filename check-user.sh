#!/bin/sh

###############################
#  check user for ftp server  #
###############################

USER_HOME=/etc/vsftpd_user_conf
DB_FILE=/etc/vsftpd_login.db
PWD_FILE=/etc/vsftpduser

if [ "$#" -ne "1" ]; then
	echo "****************************************************************"
	echo "Usage: sh $0 [argument]"
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

	if [ -e $DB_FILE ]; then
		OLD=`db4.8_dump -d a $DB_FILE | grep "\[\?\?[0 2 4 6 8]\].*len.*data: $user$" | awk -F: '{print $3}'`;
	fi
        #if [ $OLD = $user ]; then
        #        echo "Error: DB-User $user exist.";
        #fi
	if [ "$OLD" != "" ]; then
		echo "***Error***: DB-User $user exist.";
		db4.8_dump -d a $DB_FILE | grep -A 1 "\[\?\?[0 2 4 6 8]\].*len.*data: $user$";
	fi

	if [ -e $PWD_FILE ]; then
		OLD_FILE=`cat $PWD_FILE | grep "^$user:" |awk -F ":" '{print $1}'`;
	fi
	if [ "$OLD_FILE" != "" ]; then
		echo "***Error***: FILE-DB-User $user exist.";
		cat $PWD_FILE | grep "^$user:";
	fi

	if [ -e "$USER_HOME/$user" ]; then
		echo "***Error***: File $USER_HOME/$user exist.";
                #ls -l $USER_HOME/$user;
		cat $USER_HOME/"$user";
	fi

	if [ "$LD" != "" -o "$OLD" != "" -o "$OLD_FILE" != "" -o -e "$USER_HOME/$user" ]; then
		echo "\n...................... Please check it! ......................\n";
	else
		echo "\n...................... No this user: $user! .....................\n"
        fi
done
