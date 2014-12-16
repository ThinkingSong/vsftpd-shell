# vsftpd-shell

**vsftpd**使用了**pam**认证：Ldap、Berkeley db、libpam-pwdfile.

* check-user.sh 检查一个账号是否已经存在。
* pwdfilepasswd.sh 生成 pwdfile 认证账号记录。
* del-DB-user.py 删除 Berkeley db 中的 ftp 认证账号。
* add-or-update-DB-user.py 增加 Berkeley db 中的 ftp 认证账号，或为已存在的账号更新密码。
