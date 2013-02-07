#
# This is intended to be an adjunct to the Puppetlabs swift modules
#

#
# Configuration variables
#
#$swift_local_net_ip   = $ipaddress_eth0
$swift_local_net_ip = hiera('swift_local_net_ip', $ipaddress_eth1)

$galera_primary_host	=	'p1u1d-db-galera0',

#
# The node definition
#
node /galera/ {

  $primaryhost = $hostname ? {
    $galera_primary_host        =>      '',
    default                     =>      $galera_primary_host,
  }
  class { 'mariadb':
    primaryhost	=>	$primaryhost,
    ip	=>	$swift_local_net_ip,
  }
  
}

