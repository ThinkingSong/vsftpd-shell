#!/usr/bin/env python
# -*- coding:utf-8 -*-

######################################
# add or update Berkeley db ftp user #
######################################

import sys

try:
    from bsddb import db
except ImportError:
    from bsddb3 import db

FTP_DB='/etc/vsftpd_login.db'

adb = db.DB()
adb.open(FTP_DB,dbtype = db.DB_HASH)
# print adb.exists(sys.argv[1])
if adb.exists(sys.argv[1]):
#   print adb.get(sys.argv[1])
    print 'User',sys.argv[1],'will be UPDATE.'
    print '-'*10,'> It\'s OLD value is',adb.get(sys.argv[1])
else:
    print 'User',sys.argv[1],'will be ADD.'
adb.put(sys.argv[1],sys.argv[2])
adb.close()

print '\n','.'*20,'User',sys.argv[1],sys.argv[2],'is ok!','.'*20,'\n'
