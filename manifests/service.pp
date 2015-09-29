define logstash::service(
  $active = true,
) {
  service { "logstash-${name}" :
    ensure        => $active,
    enable        => $active,
    hasrestart    => true,
    hasstatus     => true,
  }
}
