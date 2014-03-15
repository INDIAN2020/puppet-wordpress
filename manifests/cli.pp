class wordpress::cli {
  file { '/usr/share/wp-cli':
    ensure  => "directory",
  }

  exec { 'wp-cli_install' :
    command => 'sudo composer create-project wp-cli/wp-cli /usr/share/wp-cli --no-dev',
    require => Class['composer']
  }

  file { 'wp-cli_link':
    ensure  => 'link',
    path    => '/usr/local/bin/wp',
    target  => '/usr/share/wp-cli/bin/wp',
    force   => true,
  }
  File['/usr/share/wp-cli']->Exec['wp-cli_install']->File['wp-cli_link']
}
