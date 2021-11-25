# Docker Image for SimpleLogin Postfix

Modified version of : https://github.com/arugifa/simplelogin-postfix-docker with TLS fixes and disabled certbot so you can add your own certificates. 

Setting     | Description
----------- | -------------------------------------------
**ALIASES_DEFAULT_DOMAIN** | Default domain to use for your aliases.
**DB_HOST** | Where is hosted your SimpleLogin PostgreSQL database.
**DB_USER** | User to connect to the database.
**DB_PASSWORD** | User's password to connect to the database.
**DB_NAME** | Name of the database.
**EMAIL_HANDLER_HOST** | Where is hosted your SimpleLogin email handler instance.
**LETSENCRYPT_EMAIL** | Email address used by Let's Encrypt, to send you expiry notices\*.
**POSTFIX_FQDN** | Fully Qualified Domain Name of your Postfix instance (i.e., the MX server address you configured in your DNS zone for your **ALIASES_DEFAULT_DOMAIN**).
**RELAY_HOST** | If your Postfix instance's IP address is blacklisted (e.g., because it is not a static address), you must use your Internet Service Provider's mail server as a relay, to be able to send emails to the outer world.
**CERTBOT_ENABLED** | Disables letsencrypt / certbot. values: true or false. default = true

\* automatic renewal is managed with [Certbot](https://certbot.eff.org/) and shouldn't fail, unless you have reached Let's Encrypt [rate limits](https://letsencrypt.org/docs/rate-limits/)

Used by and made for [Kloügle](https://github.com/arugifa/klougle), the Google
alternative automated with [Terraform](https://www.terraform.io/).


# docker-compose
Example docker compose using letsencrypt certs generated by an external linuxserver/swag container

```
 postfix:
        image: jorenn92/sl-postfix:latest
        container_name: postfix
        depends_on: #optional
          - postgres #optional
        ports:
          - "25:25"
          - 465:465
          - 587:587
        volumes:
          - /usr/apps/swag/data/etc/letsencrypt/live/<YOUR_DOMAIN_HERE>/fullchain.pem:/etc/letsencrypt/live/<YOUR_POSTFIX_FQDN_HERE>/fullchain.pem #optional
          - /usr/apps/swag/data/etc/letsencrypt/live/<YOUR_DOMAIN_HERE>/privkey.pem:/etc/letsencrypt/live/<YOUR_POSTFIX_FQDN_HERE>/privkey.pem #optional
        environment:
          - DB_HOST=<YOUR_DB_HOST>
          - DB_USER=<YOUR_DB_USER>
          - DB_PASSWORD=<YOUR_DB_PASS>
          - DB_NAME=<YOUR_DB_NAME>
          - EMAIL_HANDLER_HOST=<YOUR_EMAIL_HANDLER_HOST>
          - POSTFIX_FQDN=<YOUR_FQDN>
          - ALIASES_DEFAULT_DOMAIN=<YOUR DEFAULT DOMAIN>
          - LETSENCRYPT_EMAIL=letsencrypt@<YOUR_DEFAULT_DOMAIN>
          - CERTBOT_ENABLED=false #optional
        restart: unless-stopped
```
