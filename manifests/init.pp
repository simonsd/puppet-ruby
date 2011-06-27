import "repo.pp"
import "packages.pp"

class ruby {
	include ruby::repo
	include ruby::packages
}
