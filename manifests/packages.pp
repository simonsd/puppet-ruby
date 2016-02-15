class ruby::packages {
  @package {
    'ruby':
      ensure  => latest,
      name    => 'ruby',
      require => $::operatingsystem ? {
        default => undef,
        Centos  => $::operatingsystemrelease ? {
          /^6/    => undef,
          default => Yumrepo['kbs-el5-rb187'],
        },
      };

    'rubydevel':
      ensure  => latest,
      name    => $::operatingsystem ? {
        default => 'ruby-devel',
        Debian  => 'ruby-dev',
      },
      require => Package['ruby'];

    'rubygems':
      ensure  => installed,
      name    => 'rubygems',
      require => $::operatingsystem ? {
        default => Package['ruby'],
        Centos  => $::operatingsystemrelease ? {
          /^6/    => Package['ruby'],
          default => [ Package['ruby'], Yumrepo['epel'] ],
        },
      };

    'rubylibs':
      ensure  => latest,
      name    => 'ruby-libs',
      require => Package['ruby'];

    'rubydocs':
      ensure  => installed,
      name    => 'ruby-docs',
      require => Package['ruby'];
  }

  if $::operatingsystem != 'archlinux' {
    realize(Package['rubydevel', 'rubygems'])
  }

  realize(Package['ruby'])

  if $::operatingsystem == 'Centos' {
    realize(Package['rubylibs', 'rubydocs'])
  }

  @exec {
    'ruby enterprise':
      command => "/usr/bin/wget http://rubyforge.org/frs/download.php/71099/ruby-enterprise_1.8.7-2010.02_i386_ubuntu8.04.deb && sudo dkpg -i ruby-enterprise* && export PATH = \$PATH:/opt/ruby-enterprise/bin && export LD_LIBRARY_PATH = '/usr/local/lib'",
      cwd     => '/tmp';

    'ruby1.8-aur':
      command  => 'yaourt -S --noconfirm ruby1.8',
      provider => shell,
      unless   => 'yaourt -Qi ruby1.8',
      require  => Class['arch::yaourt'];

    'rubygems1.8-aur':
      command  => 'yaourt -S --noconfirm rubygems1.8',
      provider => shell,
      unless   => 'yaourt -Qi rubygems1.8',
      require  => Exec['ruby1.8-aur'];

    'ruby1.8_PATH':
      command  => 'sed -i \'s/^PATH=\\"/PATH=\\"\\/opt\\/ruby1.8\\/bin:/\' /etc/profile',
      unless   => 'grep \'^PATH="/opt/ruby1.8/bin:\' /etc/profile',
      provider => shell,
      require  => Exec['ruby1.8-aur'];
  }

  if $::operatingsystem == 'archlinux' {
    realize(Exec['ruby1.8-aur', 'rubygems1.8-aur', 'ruby1.8_PATH'])
  }

  if $ruby::rubyee != '' {
    realize(Exec['ruby enterprise'])
  }
}
