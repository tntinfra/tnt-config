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
    ensure => 'installed',
    provider => 'gem',
  } ->
  file { '/etc/r10k.yaml':
    ensure => 'file',
    content => $r10k_content,
  }
}

include puppetmaster
