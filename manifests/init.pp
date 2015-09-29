class logstash (
  $install_dir    = undef,
  $version        = undef,
  $installed      = true,
  $download_dir   = '/srv/download',
  $user           = 'logstash',
  $group          = 'logstash',
) {
  include logstash::params, logstash::install
}
