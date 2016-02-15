class ruby::openssl_fix {

  $ruby_dir = '/usr/lib/ruby/1.8'

  file {
    'openssl.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl.rb";

    'openssl':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl";

    'bn.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/bn.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/bn.rb";

    'buffering.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/buffering.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/buffering.rb";

    'cipher.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/cipher.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/cipher.rb";

    'config.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/config.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/config.rb";

    'digest.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/digest.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/digest.rb";

    'pkcs7.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/pkcs7.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/pkcs7.rb";

    'ssl-internal.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/ssl-internal.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/ssl-internal.rb";

    'ssl.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/ssl.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/ssl.rb";

    'x509.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/x509.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/x509.rb";

    'x509-internal.rb':
      ensure => present,
      source => 'puppet:///ruby/openssl/x509-internal.rb',
      owner  => 'root',
      group  => 'root',
      path   => "${ruby_dir}/openssl/x509-internal.rb";

  }

  package { 'ruby-static':
      ensure  => present,
      require => Yumrepo['kbs-el5-rb187'];
  }
}
