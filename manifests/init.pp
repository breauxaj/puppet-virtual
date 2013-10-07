class virtual {
  if $::is_virtual == true {
    case $::virtual {
      parallels: { include virtual::parallels }
      virtualbox: { include virtual::virtualbox }
      vmware: { include virtual::vmware }
      default: {  }
    }
  }

}
