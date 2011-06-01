class ruby {
	package { ruby:
		ensure => installed,
		name => $operatingsystem ? {
			Centos => 'ruby',
			Debian => 'ruby',
		},
	}


	package { rubydev:
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
			Centos => [ Package['ruby'], Exec['epel'] ],
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
