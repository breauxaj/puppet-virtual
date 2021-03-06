class virtual::vmware (
  $ensure = 'latest'
){
  $required = $::esx_version ? {
    /4/     => 'vmware-tools-nox',
    /5/     => 'vmware-tools-esx-nox',
    default => 'vmware-tools-esx-nox',
  }

  $vmware_path = $::esx_version ? {
    default => 'latest',
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
    source => 'puppet:///modules/virtual/VMWARE-PACKAGING-GPG-RSA-KEY.pub',
    alias  => 'vmware-tools-key',
  }

  yumrepo { 'vmware-tools':
    baseurl        => "http://packages.vmware.com/tools/esx/${vmware_path}/${os_path}/${::architecture}",
    failovermethod => 'priority',
    enabled        => '1',
    gpgcheck       => '1',
    gpgkey         => 'file:///etc/pki/rpm-gpg/VMWARE-PACKAGING-GPG-RSA-KEY.pub',
    descr          => 'VMware Tools'
  }

  package { $required:
    ensure  => $ensure,
    require => [ Yumrepo['vmware-tools'], File['vmware-tools-key'] ],
  }

}
