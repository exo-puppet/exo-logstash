class logstash::install {
  if $logstash::installed {
    # Download the archive
    wget::fetch { "download-logstash-${logstash::params::version}":
      source_url        => $logstash::params::url,
      target_directory  => $logstash::download_dir,
      target_file       => $logstash::params::download_file,
      require           => File[$logstash::download_dir],
    } ->
    # Untar the archive
    exec { "untar-logstash-${logstash::params::version}" :
      command           => "/bin/tar xf ${logstash::download_dir}/${logstash::params::download_file} --directory ${logstash::params::install_dir}",
      unless            => "test -d ${logstash::params::install_dir}/logstash-${logstash::params::version}",
    }
  } else {
    file { "${logstash::download_dir}/${logstash::params::download_file}" :
      ensure            => absent,
    } ->
    file { "${logstash::params::install_dir}/logstash-${logstash::params::version}" :
      ensure            => absent,
    }
  }
  file { "/opt/logstash" :
    ensure              => $logstash::installed ? {
      false   => absent,
      default => link },
    target            => "${logstash::params::install_dir}/logstash-${logstash::params::version}",
  } ->
  # Configuration directory
  file { "/etc/logstash" :
    ensure            => $logstash::installed ? {
      false   => absent,
      default => directory },
  } ->
  # Logs directory
  file { "/var/log/logstash" :
    ensure            => directory,
    owner   => "${logstash::user}",
    group   => "${logstash::group}",
  }
}
