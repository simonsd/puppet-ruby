import 'classes/*'
import 'definitions/*'

class ruby {
	class{'ruby::repo':} -> class{'ruby::packages':}
}
