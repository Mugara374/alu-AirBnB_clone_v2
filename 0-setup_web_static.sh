#!/usr/bin/env bash

# Install nginx if not already installed
if ! dpkg -s nginx > /dev/null 2>&1; then
    apt-get -y update
    apt-get -y install nginx
fi

# Create necessary directories if they don't exist
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/current/

# Create a fake HTML file for testing
echo "<html>
<head>
    <title>Test Page</title>
</head>
<body>
    <h1>This is a test page</h1>
    <p>Hello, world!</p>
</body>
</html>" > /data/web_static/releases/test/index.html

# Create or recreate symbolic link
rm -rf /data/web_static/current
ln -s /data/web_static/releases/test/ /data/web_static/current

# Set ownership recursively
chown -R ubuntu:ubuntu /data/

# Update nginx configuration
config_path="/etc/nginx/sites-available/default"
sed -i "/server_name _;/a \\\n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}" $config_path

# Restart nginx
service nginx restart

exit 0
