class ruby::repo {
	yumrepo { 'kbs-el5-rb187':
			descr => "kbs-el5-rb187",
			enabled=>1,
			baseurl=> "http://centos.karan.org/el5/ruby187/x86_64",
			gpgcheck=>1,
			gpgkey=> "http://centos.karan.org/RPM-GPG-KEY-karan.org.txt",
	}

	yumrepo { 'epel':
		baseurl => "http://be.mirror.eurid.eu/epel/5/$architecture",
		descr => 'epel',
		enabled => 1,
	}
}
