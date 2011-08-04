import 'classes/*'
import 'definitions/*'

class ruby {
	class{'ruby::repo':} -> class{'ruby::packages':}

	if $operatingsystem == 'centos' {
		if $operatingsystemrelease != '6.0' {
			include ruby::openssl_fix
		}
	}
}
