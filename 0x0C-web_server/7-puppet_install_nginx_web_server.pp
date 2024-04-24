# Define the server configuration
$server_config = 'server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html;
    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}'

# Ensure Nginx is installed
package { 'nginx':
    ensure => present,
}

# Create the index.html file
file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    mode    => '0644',
}

# Create the server configuration file
file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => $server_config,
}

# Restart the Nginx service
exec { 'restart_nginx':
    command => 'service nginx restart',
    path    => ['/usr/sbin', '/usr/bin'],
    require => File['/etc/nginx/sites-available/default'],
}
