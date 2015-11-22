#
# = Class: privy::rootkeys
#
# Deploys ssh private and public key for root user from hosts private section.
#
# == Requires
# 'private' section set in auth.conf on master. Definition should look something
# like this:
#
#    [private]
#     path /etc/puppet/private/%H
#     allow *
#
class privy::rootkeys {
  File {
    ensure => file,
    owner  => root,
    group  => root,
  }

  if ! defined(File['/root/.ssh']) {
    file { '/root/.ssh':
      ensure => directory,
      mode   => '0700',
    }
  }
  file { '/root/.ssh/id_rsa':
    mode   => '0600',
    source => 'puppet:///private/rootkeys/id_rsa',
  }
  file { '/root/.ssh/id_rsa.pub':
    mode   => '0644',
    source => 'puppet:///private/rootkeys/id_rsa.pub',
  }

}
