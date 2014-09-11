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

#### python2.6 does not support this parameter ####
## if adb.exists(sys.argv[1]):
#### http://www.jcea.es/programacion/pybsddb_doc/4.7.3/db.html ####
#### http://www.jcea.es/programacion/pybsddb_doc/4.8.4/db.html ####

if adb.get(sys.argv[1]):
    print '\n','.'*20,'Delete user',sys.argv[1],adb.get(sys.argv[1]),'success!','.'*20,'\n'
    adb.delete(sys.argv[1])
else:
    print '\n','.'*20,'User',sys.argv[1],'not found in Bdb!','.'*20,'\n'
adb.close()
