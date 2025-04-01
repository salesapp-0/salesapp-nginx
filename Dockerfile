FROM nginx:latest

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

# Obtain SSL certificates and start Nginx
CMD /bin/sh -c 'echo "172.17.0.1 host.docker.internal" >> /etc/hosts && \
    nginx -g "daemon off;"'
