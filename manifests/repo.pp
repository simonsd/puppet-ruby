class ruby::repo {
  if $::operatingsystem == 'Centos' {
    if $::operatingsystemrelease != '6.0' {
      realize(Yumrepo['kbs-el5-rb187', 'updates'])
    }
    realize(Yumrepo['epel'], File['epel-gpg-key'])
  }
}
