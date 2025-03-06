FROM nginx:latest

# Install Certbot
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx

COPY default.conf /etc/nginx/conf.d/default.conf

# Copy Let's Encrypt SSL configuration files
COPY options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
COPY ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem

EXPOSE 80 443

# Obtain SSL certificates and start Nginx
CMD /bin/sh -c 'echo "172.17.0.1 host.docker.internal" >> /etc/hosts && \
    certbot --nginx -d salesapp.ge -d staging.salesapp.ge -d staging-admin.salesapp.ge -d preproduction.salesapp.ge -d preproduction-admin.salesapp.ge -d soft.salesapp.ge -d soft-admin.salesapp.ge -d staging-backend.salesapp.ge -d preproduction-backend.salesapp.ge -d production-backend.salesapp.ge --non-interactive --agree-tos && \
    nginx -g "daemon off;"'

