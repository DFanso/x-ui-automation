#!/bin/bash
echo hello world

# Install Certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Obtain SSL certificates using Certbot
sudo certbot certonly --standalone --non-interactive --agree-tos --email youremail@outlook.com --domains vpn.domain.dev

# Configure x-ui to use the SSL key and certificate
mkdir -p /usr/local/x-ui/ssl
cp /etc/letsencrypt/live/vpn.dfanso.dev/fullchain.pem /usr/local/x-ui/ssl/fullchain.pem
cp /etc/letsencrypt/live/vpn.dfanso.dev/privkey.pem /usr/local/x-ui/ssl/privkey.pem

# Set permissions
chmod 644 /usr/local/x-ui/ssl/fullchain.pem
chmod 600 /usr/local/x-ui/ssl/privkey.pem

# Download and run the installation script
bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh) << EOF
y
dfanso
Iamleogavin@0214
31402
EOF

# Set the web base path to an empty string
/usr/local/x-ui/x-ui setting -webBasePath ""

# Configure x-ui with the SSL key and certificate
/usr/local/x-ui/x-ui setting -webCert /etc/letsencrypt/live/vpn.dfanso.dev/fullchain.pem -webCertKey /etc/letsencrypt/live/vpn.dfanso.dev/privkey.pem



# Restart x-ui service
systemctl restart x-ui
