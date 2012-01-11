class ruby::post {
	exec {
		"gem_update":
	    	command => "gem update --system",
	    	cwd => "/root",
	    	timeout => "-1",
			require => Class["ruby::packages"];
	}
}
