class ruby::packages {
	package {
		ruby:
			ensure => latest,
			name => 'ruby',
			require => $::operatingsystem ? {
				default => undef,
				Centos => $::operatingsystemrelease ? {
					'6.0' => undef,
					'*' => Yumrepo["kbs-el5-rb187"],
				},
			};

/*
		rubydevel:
			ensure => latest,
			name => $::operatingsystem ? {
				archlinux => undef,
				Centos => 'ruby-devel',
				Debian => 'ruby-dev',
			},
			require => Package['ruby'];
*/

		rubygems:
			ensure => installed,
			name => 'rubygems',
			require => $::operatingsystem ? {
				default => Package['ruby'],
				Centos => $::operatingsystemrelease ? {
					'6.0' => Package['ruby'],
					'*' => [ Package['ruby'], Yumrepo['epel'] ],
				},
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

	if $::operatingsystem == "Centos" {
		realize(Package['rubylibs', 'rubydocs'])
	}

	@exec { 'ruby enterprise':
		command => "/usr/bin/wget http://rubyforge.org/frs/download.php/71099/ruby-enterprise_1.8.7-2010.02_i386_ubuntu8.04.deb && sudo dkpg -i ruby-enterprise* && export PATH=$PATH:/opt/ruby-enterprise/bin && export LD_LIBRARY_PATH='/usr/local/lib'",
		cwd => '/tmp',
	}

	if $ruby::rubyee != "" {
		realize(Exec['ruby enterprise'])
	}
}
