class ruby::repo {
	@yumrepo {
		'kbs-el5-rb187':
			descr => "kbs-el5-rb187",
			enabled =>1,
			baseurl => "http://centos.karan.org/el5/ruby187/$::hardwaremodel",
			gpgcheck =>1,
			gpgkey => "http://centos.karan.org/RPM-GPG-KEY-karan.org.txt";

		'epel':
			descr => 'EPEL',
			enabled => 1,
			baseurl => $::operatingsystem ? {
				'Centos' => $::operatingsystemrelease ? {
					'5.*' => "http://mirror.eurid.eu/epel/5/$::hardwaremodel/",
					'6.0' => "http://mirror.eurid.eu/epel/6/$::hardwaremodel/",
				},
				'Debian' => undef,
			},
			gpgcheck => 0;

		"updates":
			baseurl => absent,
			mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates',
			enabled => 1,
			exclude => "ruby*",
			gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5';
	}

	if $::operatingsystem == 'Centos' {
		if $::operatingsystemrelease != '6.0' {
			realize(Yumrepo['kbs-el5-rb187', 'updates'])
		}
		realize(Yumrepo['epel'])
	}
}
