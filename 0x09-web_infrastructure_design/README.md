# Web Infrastructure Design and Explanation

This README file provides an overview of the web infrastructure design for the website www.foobar.com. The design evolves from a single server setup to a three-server setup with load balancing, security, and monitoring.

## Single Server Setup

The initial setup involves a single server hosting the website. The server includes a web server (Nginx), an application server, application files (codebase), and a MySQL database. The domain name foobar.com is configured with a www record that points to the server IP 8.8.8.8.

### Explanation of Components

- **Server**: A server is a computer or system that provides resources, data, services, or programs to other computers, known as clients, over a network.
- **Domain Name**: The domain name serves as the address of the server. It's easier to remember and use than an IP address.
- **DNS Record**: The 'www' in www.foobar.com is a type of DNS record. It's typically used to point to the IP address of a web server.
- **Web Server**: The web server (Nginx in this case) serves the requested HTML pages or files to the client.
- **Application Server**: The application server runs the application logic (the codebase). It interacts with the web server to fulfill user requests.
- **Database**: The database (MySQL in this case) stores and retrieves data for the application.

The server communicates with the user's computer via HTTP/HTTPS protocols.

### Issues with Single Server Setup

- **Single Point of Failure (SPOF)**: If the single server goes down, the entire website becomes unavailable.
- **Maintenance Downtime**: Deploying new code or updates may require restarting the web server, causing downtime.
- **Limited Scalability**: If the website receives too much traffic, a single server may not be able to handle the load.

## Three Server Setup

The next iteration involves three servers: one for the web server, one for the application server, and one for the database. A load balancer (HAproxy) is added to distribute network traffic across the servers.

### Explanation of Additional Components

- **Additional Servers**: More servers are added to handle increased traffic and provide redundancy.
- **Load Balancer**: The load balancer distributes network traffic across multiple servers to ensure no single server bears too much load. It can be configured with various distribution algorithms, such as round-robin or least connections. It can also enable an Active-Active (all servers are available) or Active-Passive (one server is primary, others are backups) setup.
- **Database Cluster**: A Primary-Replica (Master-Slave) database cluster can ensure data consistency across multiple servers. The Primary node handles writes, and the Replica nodes handle reads.

### Issues with Three Server Setup

- **Single Points of Failure**: There are still SPOFs in this setup, such as the load balancer or the database.
- **Security**: Without a firewall or HTTPS, the website is vulnerable to attacks.
- **No Monitoring**: Without monitoring, it's difficult to track performance or identify issues.

## Secured and Monitored Three Server Setup

The final setup adds firewalls for each server, an SSL certificate for HTTPS traffic, and monitoring clients for performance tracking.

### Explanation of Additional Components

- **Firewalls**: Firewalls control the incoming and outgoing network traffic based on predetermined security rules, protecting the servers from unauthorized access.
- **SSL Certificate**: Serving traffic over HTTPS encrypts the communication between the user's browser and the servers, protecting data integrity and confidentiality.
- **Monitoring Clients**: Monitoring tools collect data about the servers' performance. They can track various metrics, such as the web server's queries per second (QPS).

### Issues with Secured and Monitored Setup

- **SSL Termination at Load Balancer**: This can create a bottleneck and also expose unencrypted traffic if the internal network is compromised.
- **Single MySQL Write Server**: Only one MySQL server can accept writes, which can be a bottleneck.
- **Same Components on All Servers**: This can lead to inefficient resource use, as different components have different resource requirements.

## Application Server vs Web Server

In a typical web application, the web server and application server have distinct roles. The web server handles HTTP requests and serves static content, while the application server runs the application logic and dynamically generates content. Separating these roles across different servers can improve scalability and reliability.

## Conclusion

This README provides an overview of the evolution of a web infrastructure design, from a single server setup to a secured and monitored multi-server setup. Each step addresses specific issues and improves upon the previous design. However, each setup also has its own potential issues and areas for further improvement. It's important to continually monitor and adjust the infrastructure based on the needs and performance of the application. 

Please note that this is a simplified explanation and actual web infrastructure design can be much more complex and requires careful planning and consideration of various factors such as traffic patterns, data consistency requirements, security, and cost.