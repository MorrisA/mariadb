class mariadb ($primaryhost = '', $ip,) {
  package{'mariadb-galera-server':
    ensure	=>	installed,
  }
  package{'galera':
    ensure	=>	installed,
  }
  file{'my.cnf':
    require	=>	Package['mariadb-galera-server'],
    ensure	=>	file,
    path	=>	'/etc/mysql/my.cnf',
    owner	=>	'root',
    group	=>	'root',
    mode	=>	'0644',
    source	=>	"puppet:///modules/mariadb/my.cnf",
  }
  file{'mariadb.cnf':
    require	=>	Package['mariadb-galera-server'],
    ensure	=>	file,
    path	=>	'/etc/mysql/conf.d/mariadb.cnf',
    owner	=>	'root',
    group	=>	'root',
    mode	=>	'0644',
    content	=>	template("mariadb/mariadb.erb"),
  }

  # Start the database
  service{'mysql':
    ensure	=>	running,
    subscribe	=>	File['my.cnf'],
  }
}
