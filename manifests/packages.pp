class ruby::packages {
	package { ruby:
		ensure => $operatingsystem ? {
			Centos => "latest",
			Debian => "1.8.7",
		},
		name => $operatingsystem ? {
			Centos => 'ruby',
			Debian => 'ruby',
		},
		require => $operatingsystem ? {
			Centos => Yumrepo["kbs-el5-rb187"],
			Default => undef,
		},
	}

	package { rubylibs:
		ensure => latest,
		name => ruby-libs,
		require => Package['ruby'],
	}

	package { rubydevel:
		ensure => installed,
		name => $operatingsystem ? {
			Centos => 'ruby-devel',
			Debian => 'ruby-dev',
		},
		require => Package['ruby'],
	}

	package { rubygems:
		ensure => installed,
		name => $operatingsystem ? {
			Centos => 'rubygems',
			Debian => 'rubygems',
		},
		require => $operatingsystem ? {
			Centos => [ Package['ruby'], Yumrepo['epel'] ],
			Debian => Package['ruby'],
		},
	}

	package { rubydocs:
		ensure => installed,
		name => $operatingsystem ? {
			Centos => 'ruby-docs',
			Debian => 'ruby',
		},
		require => Package['ruby'],
	}
}
