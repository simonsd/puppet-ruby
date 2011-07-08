class ruby::packages {
	package {
		ruby:
			ensure => latest,
			name => 'ruby',
			require => $operatingsystem ? {
				Centos => Yumrepo["kbs-el5-rb187"],
				Debian => undef,
			};

		rubylibs:
			ensure => latest,
			name => ruby-libs,
			require => Package['ruby'];

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

		rubydocs:
			ensure => installed,
			name => $operatingsystem ? {
				Centos => 'ruby-docs',
				Debian => undef,
			},
			require => Package['ruby'];
	}
}
