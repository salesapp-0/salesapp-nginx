FROM nginx:latest

# Install Certbot
# RUN apt-get update && \
#     apt-get install -y certbot python3-certbot-nginx

# Install iproute2 for the `ip` command
RUN apt-get update && apt-get install -y iproute2
# RUN mkdir /certs

COPY default.conf /etc/nginx/conf.d/default.conf
# COPY localhost.crt /certs/localhost.crt
# COPY localhost.key /certs/localhost.key

# Copy Let's Encrypt SSL configuration files
# COPY options-ssl-nginx.conf /etc/letsencrypt/options-ssl-nginx.conf
# COPY ssl-dhparams.pem /etc/letsencrypt/ssl-dhparams.pem

EXPOSE 80 443

CMD /bin/sh -c 'host_ip=$(ip route | awk "/default/ { print $3 }") && \
    echo "$host_ip host.docker.internal" >> /etc/hosts && \
    nginx -g "daemon off;"'

