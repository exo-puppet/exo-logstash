define logstash::plugin {

  exec { "logstash-plugin-${name}" :
    cwd         => "/opt/logstash/bin",
    command     => "/opt/logstash/bin/plugin install ${name}",
    refreshonly => true,
    subscribe   => Exec ["untar-logstash-${logstash::params::version}"],
  }
}
