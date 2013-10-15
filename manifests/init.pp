class virtual {
  if $::is_virtual == 'true' {
    case $::virtual {
      'parallels': { include parallels }
      'virtualbox': { include virtualbox }
      'vmware': { include vmware }
      default: {  }
    }
  }

}
