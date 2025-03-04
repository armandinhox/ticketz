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

ENTRYPOINT ["dumb-init", "--"]
CMD (echo "{" && while IFS='=' read -r name value; do \
        printf '\t"%s": "%s"\n' "$name" "$value"; \
    done < <(env) | sed '$!s/$/,/' && echo "}")  > /usr/share/nginx/html/config.json \
    && nginx -g "daemon off;"