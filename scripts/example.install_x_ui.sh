#!/bin/bash


PORT=31402
LOGIN_URL="http://localhost:$PORT/login"
UPDATE_URL="http://localhost:$PORT/panel/setting/update"
USERNAME=""
PASSWORD=""
EMAIL=""
DOMAIN=""
SSL_DIR="/usr/local/x-ui/ssl"
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh"
COOKIE_FILE="cookies.txt"
COOKIE_NAME="3x-ui"
X_UI_DB_SOURCE="/root/x-ui.db"
X_UI_DB_DESTINATION="/etc/x-ui/x-ui.db"


echo "Getting SSL Cert"

# Install Certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Obtain SSL certificates using Certbot
sudo certbot certonly --standalone --non-interactive --agree-tos --email $EMAIL --domains $DOMAIN

# Configure x-ui to use the SSL key and certificate
mkdir -p $SSL_DIR
cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem $SSL_DIR/fullchain.pem
cp /etc/letsencrypt/live/$DOMAIN/privkey.pem $SSL_DIR/privkey.pem

# Set permissions
chmod 644 $SSL_DIR/fullchain.pem
chmod 600 $SSL_DIR/privkey.pem

echo "Installing Pannel"

# Download and run the installation script
bash <(curl -Ls $INSTALL_SCRIPT_URL) << EOF
y
$USERNAME
$PASSWORD
$PORT
EOF

# Set the web base path to an empty string
/usr/local/x-ui/x-ui setting -webBasePath ""

# Configure x-ui with the SSL key and certificate
/usr/local/x-ui/x-ui setting -webCert /etc/letsencrypt/live/$DOMAIN/fullchain.pem -webCertKey /etc/letsencrypt/live/$DOMAIN/privkey.pem



echo "Pannel Installed successfully"

sleep 5

# Make a POST request and capture the cookies
curl -c $COOKIE_FILE -d "username=$USERNAME" -d "password=$PASSWORD" -X POST $LOGIN_URL

# Extract the cookie value
COOKIE_VALUE=$(grep "$COOKIE_NAME" $COOKIE_FILE | awk '{print $7}')

# Set the cookie as a variable for future requests
COOKIE="Cookie: $COOKIE_NAME=$COOKIE_VALUE"

# Print the cookie for verification
echo "Extracted cookie: $COOKIE"

# Wait for 5 seconds
sleep 5

# Prepare the data for the update request
DATA="webDomain=&webPort=31402&webCertFile=/etc/letsencrypt/live/$DOMAIN/fullchain.pem&webKeyFile=/etc/letsencrypt/live/$DOMAIN/privkey.pem&webBasePath=/&sessionMaxAge=0&pageSize=50&expireDiff=0&trafficDiff=0&remarkModel=-ieo&datepicker=gregorian&tgBotEnable=false&tgBotToken=&tgBotProxy=&tgBotChatId=&tgRunTime=@daily&tgBotBackup=false&tgBotLoginNotify=true&tgCpu=80&tgLang=en-US&xrayTemplateConfig=&secretEnable=false&subEnable=false&subListen=&subPort=2096&subPath=/sub/&subJsonPath=/json/&subDomain=&subCertFile=&subKeyFile=&subUpdates=12&subEncrypt=true&subShowInfo=true&subURI=&subJsonURI=&subJsonFragment=&subJsonMux=&subJsonRules=&timeLocation=Asia/Tehran"

# Make the update request with the captured cookie
curl -b "$COOKIE_NAME=$COOKIE_VALUE" -d "$DATA" -H "Content-Type: application/x-www-form-urlencoded" -X POST $UPDATE_URL

# Clean up the cookie file
rm $COOKIE_FILE

echo "SSL Updated"

# Copy the x-ui.db file
if [ -f "$X_UI_DB_SOURCE" ]; then
  echo "Copying x-ui.db file to $X_UI_DB_DESTINATION"
  sudo cp "$X_UI_DB_SOURCE" "$X_UI_DB_DESTINATION"
else
  echo "x-ui.db file not found at $X_UI_DB_SOURCE"
fi

# Restart x-ui service
systemctl restart x-ui