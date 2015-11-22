# Class: privy::iptables
class privy::iptables (
  $source = 'puppet:///private/iptables',
  ){
#  include ::ulog

  file { '/etc/sysconfig/iptables':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0600',
    source => $source,
  }
  service { 'iptables':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/sysconfig/iptables'],
  }
}
