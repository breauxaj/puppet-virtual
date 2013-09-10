class virtual::vmware {
  $required = $::esx_version ? {
    /4/     => 'vmware-tools-nox',
    /5/     => 'vmware-tools-esx-nox',
    default => 'vmware-tools-esx-nox',
  }

  $vmware_path = $::esx_version ? {
    /4/     => '4.1latest',
    /5/     => '5.0latest',
    default => '5.0latest',
  }
    
  $os_path = $::lsbmajdistrelease ? {
    /5/     => 'rhel5',
    /6/     => 'rhel6',
    default => 'rhel6',
  }
    
  file { '/etc/yum.repos.d/vmware-tools.repo':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => template('virtual/vmware-tools.erb'),
  }
    
  package { $required:
    ensure  => latest,
    require => File['/etc/yum.repos.d/vmware-tools.repo'],    
  }

}
