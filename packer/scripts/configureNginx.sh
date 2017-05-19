#!/bin/bash

# Script to install and setup Nginx and enable on boot.

# Update system
apt-get update -y
apt-get upgrade -y

# Install Nginx
apt-get install -y nginx

# Start Nginx service and enable to start on boot
systemctl enable nginx
systemctl start nginx

# Create a backup of the original configuration files and import configuration
cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
cp /tmp/nginx.conf /etc/nginx/nginx.conf

# Setup a website with the desired server block and permissions
mkdir -p /var/www/html/example.com
chown -R www-data:www-data /var/www/html/example.com
chmod 755 /var/www
cp /tmp/example.com/example.com /etc/nginx/sites-available/example.com

# Activate the host by creating a symbolic link between the sites-available directory and the sites-enabled directory
ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/example.com

# Delete the default nginx server block
rm /etc/nginx/sites-enabled/default

# Copy over the html test page
cp /tmp/example.com/index.html /var/www/html/example.com/index.html

# Restart Nginx:
systemctl restart nginx