FROM node:alpine AS build-deps
WORKDIR /usr/src/app/
COPY . .
RUN npm ci
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html/
RUN apk update
RUN apk add dumb-init nodejs npm
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
COPY --from=build-deps /usr/src/app/node_modules/@socket.io/admin-ui/ui/dist /usr/share/nginx/html/socket-admin
COPY nginx /etc/nginx

EXPOSE 80
#COPY ./build /usr/share/nginx/html
#COPY ./node_modules/@socket.io/admin-ui/ui/dist /usr/share/nginx/html/socket-admin
#COPY nginx /etc/nginx

CMD (echo "{" && while IFS='=' read -r name value; do \
        printf '\t"%s": "%s"\n' "$name" "$value"; \
    done < <(env) | sed '$!s/$/,/' && echo "}")  > /var/www/public/config.json \
    && if [ -n "$BACKEND_SERVICE" ]; then \
        BACKEND_IP=$(getent hosts $BACKEND_SERVICE | awk '{ print $1 }') \
        && echo "$BACKEND_IP backend" >> /etc/hosts; \
    fi \
    && nginx -g "daemon off;"