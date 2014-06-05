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
    print '>'*3,'It\'s OLD value is',adb.get(sys.argv[1])
    print '\n','.'*20,'User',sys.argv[1],sys.argv[2],'is UPDATE!','.'*20,'\n'
else:
    print '\n','.'*20,'User',sys.argv[1],sys.argv[2],'is ADD!','.'*20,'\n'
adb.put(sys.argv[1],sys.argv[2])
adb.close()

