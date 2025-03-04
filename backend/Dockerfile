FROM node:20 AS build

WORKDIR /usr/src/app
COPY . .

RUN --mount=type=cache,target=/root/.npm \
    npm ci && npm run build

COPY --from=build --parents \
  /usr/src/app/./dist \
  /usr/src/app/./node_modules \
  /usr/src/app/./package.json \
  /usr/src/app/scripts/

ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000

CMD dockerize -wait tcp://${DB_HOST}:5432 -timeout 60s \
  && npx sequelize db:migrate  --config dist/config/database.js --migrations-path dist/database/migrations \
  && ./scripts/load-retrieved.sh /retrieve; exit_code=$? \
  && if [ $exit_code -eq 1 ]; then npm run mark-seeds; exit 0; elif [ $exit_code -ge 100 ]; then exit 1; fi \
  && npx sequelize db:seed:all --config dist/config/database.js --seeders-path dist/database/seeds \
  && node dist/server.js
