class mariadb::keystone(
  $password,
  $dbname	=	'keystone',
  $user		=	'keystone_admin',
) {
  exec{ "create_db":
    command 	=>	"/usr/bin/mysql --defaults-file=/etc/mysql/debian.cnf -e \"create database ${dbname};\"",
    cwd		=>	"/",
    creates	=>	"/var/lib/mysql/${dbname}/db.opt",
    before	=>	Exec['grant_access'],
  }
  exec{ "grant_access":
    command 	=>	"/usr/bin/mysql --defaults-file=/etc/mysql/debian.cnf -e \"grant all on ${dbname}.* to '${user}'@'%' identified by '${password}';\"",
    cwd		=>	"/",
  }
}
