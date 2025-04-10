FROM nginx:latest

RUN mkdir -p /usr/share/nginx/html/.well-known/acme-challenge

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443

CMD /bin/sh -c 'echo "172.17.0.1 host.docker.internal" >> /etc/hosts && \
    nginx -g "daemon off;"'