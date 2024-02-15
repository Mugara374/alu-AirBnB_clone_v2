#!/usr/bin/env bash
# script that sets up web servers for the deployment of web_static

# Update package lists
sudo apt-get update

# Install Nginx
sudo apt-get -y install nginx

# Allow HTTP traffic through the firewall
sudo ufw allow 'Nginx HTTP'

# Create necessary directories and files with sudo privileges using a here document
sudo bash <<EOF
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/current/
touch /data/web_static/releases/test/index.html
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | tee /data/web_static/releases/test/index.html > /dev/null
ln -sf /data/web_static/releases/test/ /data/web_static/current
chown -R ubuntu:ubuntu /data/
EOF

# Update Nginx configuration
sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

# Restart Nginx
sudo service nginx restart

# Exit with success
exit 0
