import 'classes/*'
import 'definitions/*'

class ruby {
	include ruby::repo
	include ruby::packages

	Class['ruby::repo'] -> Class['ruby::packages']
}
