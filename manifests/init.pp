import 'classes/*'
import 'definitions/*'

class ruby (
	$stages = 'no',
	$home = '/usr',
	$lib_dir = '/usr/lib64/ruby',
	$bin_dir = '/usr/bin'
) {
	if $stages != 'yes' {
		class{'ruby::repo':} -> class{'ruby::packages':}
	} else {
		class{
			'ruby::repo':
				stage => repo;
			'ruby::packages':
				stage => depends;
		}
	}

	if $operatingsystem == 'centos' {
		if $operatingsystemrelease != '6.0' {
			include ruby::openssl_fix
		}
	}
}
