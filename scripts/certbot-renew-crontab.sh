#!/usr/bin/env sh
set -e

CERTBOT_ENABLED="${CERTBOT_ENABLED:-true}"
CERTIFICATE="/etc/letsencrypt/live/$POSTFIX_FQDN/fullchain.pem"
PRIVATE_KEY="/etc/letsencrypt/live/$POSTFIX_FQDN/privkey.pem"

if [ $CERTBOT_ENABLED = true ];then
	if [ -f $CERTIFICATE -a -f $PRIVATE_KEY ]; then
    		certbot -n renew
	else
    		certbot -n certonly
	fi
	else
		echo "Certbot disabled. Container will run WITHOUT TLS"
fi
