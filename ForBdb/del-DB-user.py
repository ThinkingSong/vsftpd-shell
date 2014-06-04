#!/usr/bin/env python
# -*- coding:utf-8 -*-

###############################
# delete Berkeley db ftp user #
###############################

import sys

try:
    from bsddb import db
except ImportError:
    from bsddb3 import db


FTP_DB='/etc/vsftpd_login.db'

adb = db.DB()
adb.open(FTP_DB,dbtype = db.DB_HASH)
adb.delete(sys.argv[1])
adb.close()

print '\n','.'*20,'Delete user',sys.argv[1],'success!','.'*20,'\n'
