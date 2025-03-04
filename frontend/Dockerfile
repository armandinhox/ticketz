FROM node:20.18-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
FROM nginx:alpine
EXPOSE 80
#COPY ./build /usr/share/nginx/html
#COPY ./node_modules/@socket.io/admin-ui/ui/dist /usr/share/nginx/html/socket-admin
COPY nginx /etc/nginx

CMD (echo "{" && while IFS='=' read -r name value; do \
        printf '\t"%s": "%s"\n' "$name" "$value"; \
    done < <(env) | sed '$!s/$/,/' && echo "}")  > /var/www/public/config.json \
    && if [ -n "$BACKEND_SERVICE" ]; then \
        BACKEND_IP=$(getent hosts $BACKEND_SERVICE | awk '{ print $1 }') \
        && echo "$BACKEND_IP backend" >> /etc/hosts; \
    fi \
    && nginx -g "daemon off;"