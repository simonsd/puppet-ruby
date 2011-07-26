import 'repo.pp'
import 'packages.pp'
import 'openssl_fix.pp'
import 'post.pp'
import 'define.pp'

class ruby {
	include ruby::repo
	include ruby::packages

	Class['ruby::repo'] -> Class['ruby::packages']
}
