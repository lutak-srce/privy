# Class: privy::iptables
class privy::iptables (
  $source = 'puppet:///private/iptables',
  $source6 = 'puppet:///modules/srce/iptables/ip6tables-default',
  ) {

  case $facts['os']['family'] {
    'RedHat' : {
      if $facts['os']['release']['major'] == '7' { 
        package { 'iptables-services': ensure => present, } 
      }   
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
    'Debian' : {
      if $facts['os']['release']['major'] == '8' { 
        package { 'iptables-persistent': ensure => present, }
        file { '/etc/iptables/rules.v4':
          ensure => file,
          owner  => root,
          group  => root,
          mode   => '0644',
          source => $source,
        }
        file { '/etc/iptables/rules.v6':
          ensure => file,
          owner  => root,
          group  => root,
          mode   => '0644',
          source => $source6,
        }
        service { 'netfilter-persistent':
          ensure    => running,
          enable    => true,
          subscribe => File['/etc/iptables/rules.v4','/etc/iptables/rules.v6'],
        }
      } else { notify{"privy::iptables does not support this OS !!!": } }
    }
    default: { notify{"privy::iptables does not support this OS !!!": } }
  }
}
