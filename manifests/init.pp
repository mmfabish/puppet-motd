class motd {
  
  file { '/etc/motd':
    ensure => file,
    content => template('motd/motd.erb'),
  }

  package { 'ssh':
    name => 'openssh',
    ensure => installed,
  } 

  file { 'ssh_config':
    name => '/etc/ssh/sshd_config',
    ensure => file,
    source => 'puppet:///modules/motd/sshd_config',
    require => Package['ssh'],
  }

  service { 'ssh':
    name => 'sshd',
    ensure => running,
    enable => true,
    subscribe => File['ssh_config'],
  }
}
