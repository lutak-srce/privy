#
# = Class: privy::facts
#
# == Parameters
#
# [*source*]
#  Type: string, Default: 'puppet:///modules/private/facts'
#  Defines the source directory for custom facts. You can use
#  private source by setting value to 'puppet:///private/facts'.
class privy::facts (
  $source = 'puppet:///modules/private/facts',
  ){

  File {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { '/etc/facter': }

  file { '/etc/facter/facts.d' :
    source => $source,
  }

}
