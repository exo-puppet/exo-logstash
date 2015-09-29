define logstash::instance (
  $config_dir,
  $active         = true,
  $heap_size      = "500m",
) {
  # Install init file
  file { "/etc/init.d/logstash-${name}" :
    ensure  => $active ? {
      false     => absent,
      default   => present },
    owner   => "${logstash::user}",
    group   => "${logstash::group}",
    mode    => 744,
    content => template('logstash/logstash.init.erb'),
  } ->
  logstash::service { "${name}" :
    active  => $active,
  }
  # Install configuration
  file { "/etc/logstash-${name}" :
    ensure  => $active ? {
      false   => absent,
      default => directory },
    owner   => "${logstash::user}",
    group   => "${logstash::group}",
  } ->
  file { "/etc/logstash-${name}/conf.d" :
    ensure  => $active ? {
      false   => absent,
      default => directory },
    recurse => true,
    source  => "${config_dir}",
    owner   => "${logstash::user}",
    group   => "${logstash::group}",
    notify  => Service["logstash-${name}"]
  }

}
