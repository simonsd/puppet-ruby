class ruby::packages {
	package {
		ruby:
			ensure => latest,
			name => 'ruby',
			require => $operatingsystem ? {
				Centos => Yumrepo["kbs-el5-rb187"],
				Debian => undef,
			};

		rubydevel:
			ensure => latest,
			name => $operatingsystem ? {
				Centos => 'ruby-devel',
				Debian => 'ruby-dev',
			},
			require => Package['ruby'];

		rubygems:
			ensure => installed,
			name => 'rubygems',
			require => $operatingsystem ? {
				Centos => [ Package['ruby'], Yumrepo['epel'] ],
				Debian => Package['ruby'],
			};
	}

	@package {
		rubylibs:
			ensure => latest,
			name => 'ruby-libs',
			require => Package['ruby'];

		rubydocs:
			ensure => installed,
			name => 'ruby-docs',
			require => Package['ruby'];
	}

	if $operatingsystem == "Centos" {
		realize(Package['rubylibs', 'rubydocs'])
	}
}
