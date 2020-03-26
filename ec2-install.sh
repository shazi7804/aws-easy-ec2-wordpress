#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd php-gd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/
chown -R apache.apache /var/www
sudo chmod 2775 /var/www

sudo tee -a /etc/httpd/conf/httpd.conf <<EOF
<Directory "/var/www/html">
  Options Indexes FollowSymLinks
  AllowOverride All
  Require all granted
</Directory>
EOF

sudo systemctl restart httpd
