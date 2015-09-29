class logstash::params {
  $version        = $logstash::version ? {
    undef   => "1.5.4",
    default => $logstash::version
  }

  $download_file  = "logstash-${version}.tar.gz"

  $url            = "https://download.elastic.co/logstash/logstash/${download_file}"

  $install_dir    = $logstash::install_dir ? {
    undef   => "/opt",
    default => $logstash::install_dir
  }

  $data_dir       = '/opt/logstash'
}
