FROM nginx:latest

# Install Certbot
# RUN apt-get update && \
#     apt-get install -y certbot python3-certbot-nginx

COPY default.conf /etc/nginx/conf.d/default.conf

# Copy Let's Encrypt SSL configuration files
# COPY options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
# COPY ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem

# EXPOSE 80 443
EXPOSE 80

CMD /bin/sh -c 'echo "172.17.0.1 host.docker.internal" >> /etc/hosts && \
    nginx -g "daemon off;"'

