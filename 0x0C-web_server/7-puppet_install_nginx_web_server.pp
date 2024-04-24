class nginx_install {
    package { 'nginx':
        ensure => installed,
    }

    file { '/var/www/html/index.nginx-debian.html':
        ensure  => file,
        content => 'Hello World!',
        require => Package['nginx'],
    }

    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => '
            server {
                listen 80;
                server_name localhost;
                location / {
                    root /var/www/html;
                    index index.nginx-debian.html;
                }
                location = /redirect_me {
                    return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
                }
            }
        ',
        notify  => Service['nginx'],
        require => Package['nginx'],
    }

    service { 'nginx':
        ensure    => running,
        enable    => true,
        subscribe => File['/etc/nginx/sites-available/default'],
    }
}

include nginx_install
