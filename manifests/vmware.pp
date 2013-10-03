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

  file { '/etc/pki/rpm-gpg/VMWARE-PACKAGING-GPG-RSA-KEY.pub':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "puppet:///modules/virtual/VMWARE-PACKAGING-GPG-RSA-KEY.pub",
  }

  yumrepo { 'vmware-tools':
    baseurl        => "http://packages.vmware.com/tools/esx/${vmware_path}/${os_path}/${::architecture}",
    failovermethod => 'priority',
    enabled        => '1',
    gpgcheck       => '1',
    gpgkey         => "file:///etc/pki/rpm-gpg/VMWARE-PACKAGING-GPG-RSA-KEY.pub",
    descr          => "VMware Tools"
  }

  package { $required:
    ensure  => latest,
    require => Yumrepo['vmware-tools'],
  }

}
