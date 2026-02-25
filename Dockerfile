FROM nginx:stable-alpine3.20-slim

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./index.html /usr/share/nginx/html/index.html

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]