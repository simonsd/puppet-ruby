class ruby::repo {
	yumrepo { "kbs-el5-rb187":
			descr => "kbs-el5-rb187",
			enabled=>1,
			baseurl=> "http://centos.karan.org/el5/ruby187/i386",
			gpgcheck=>1,
			gpgkey=> "http://centos.karan.org/RPM-GPG-KEY-karan.org.txt",
	}

	yumrepo { 'epel':
		baseurl => 'http://be.mirror.eurid.eu/epel',
		descr => 'epel',
		enabled => 1,
	}
}
