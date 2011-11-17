import 'classes/*'
import 'definitions/*'

class ruby (
	$stages = 'no',
	$home = $::operatingsystem ? {
		default => '/usr',
		archlinux => '/opt/ruby1.8',
	},
	$lib_dir = $::operatingsystem ? {
		default => $::hardwaremodel ? {
			default => '/usr/lib/ruby',
			x86_64 => '/usr/lib64/ruby',
		},
		archlinux => '/opt/ruby1.8/lib/ruby',
		debian => '/var/lib',
	},
	$bin_dir = $::operatingsystem ? {
		default => '/usr/bin',
		archlinux => '/opt/ruby1.8/bin',
	},
	$usecrappyhttpdmodule = 'no',
	$version = '1.8'
) {
	if $ruby::stages != 'yes' {
		class {
			'ruby::repo':
				before => Class['ruby::packages'];
			'ruby::packages':;
		}
	} else {
		class{
			'ruby::repo':
				stage => repo;
			'ruby::packages':
				stage => depends;
		}
	}

	if $::operatingsystem == 'centos' {
		if $::operatingsystemrelease != '6.0' {
			include ruby::openssl_fix
		}
	}

	if $ruby::usecrappyhttpdmodule == 'yes' {
		realize(Package['httpd-devel'])
		include passenger
	}
}
