class puppetmaster {
  package { 'puppetserver':
    ensure => 'installed',
  } -> 
  service { 'puppetserver':
    ensure => 'running',
    enable => true,
  }
}
