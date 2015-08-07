class puppetmaster {
  $r10k_content = ":cachedir: '/var/cache/r10k'
:sources:
  :plops:
    remote: 'https://github.com/tntinfra/puppet-tnt.git'
    basedir: '/etc/puppet/environments'\n"

  package { 'puppetserver':
    ensure => 'installed',
  } ->
  service { 'puppetserver':
    ensure => 'running',
    enable => true,
  }

  package { 'r10k':
    ensure => '2.0.2',
    provider => 'gem',
  } ->
  file { '/etc/puppetlabs/r10k':
    ensure => 'directory',
  } ->
  file { '/etc/puppetlabs/r10k/r10k.yaml':
    ensure => 'file',
    content => $r10k_content,
  }
}

include puppetmaster
