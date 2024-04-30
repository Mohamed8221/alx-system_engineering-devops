# 2-puppet_custom_http_response_header.pp
class nginx_custom_header {
  $package_name = 'nginx'
  $service_name = 'nginx'
  $config_file_path = '/etc/nginx/sites-available/default'
  $header_name = 'X-Served-By'
  $hostname = inline_template('<%= @fqdn %>')

  package { $package_name:
    ensure => installed,
  }

  service { $service_name:
    ensure => running,
    enable => true,
    require => Package[$package_name],
  }

  file { $config_file_path:
    ensure  => file,
    content => template('nginx/default.erb'),
    require => Package[$package_name],
    notify  => Service[$service_name],
  }
}
