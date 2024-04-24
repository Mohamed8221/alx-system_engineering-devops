# Use an official Ubuntu 14.04 runtime as the parent image
FROM ubuntu:14.04

# Update the system
RUN apt-get update

# Install Apache
RUN apt-get install -y apache2

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Add your custom HTML file
ADD index.html /var/www/html/

# Use /bin/bash to run subsequent commands
ENTRYPOINT ["/bin/bash"]

