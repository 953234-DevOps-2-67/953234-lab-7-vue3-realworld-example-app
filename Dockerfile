FROM node:23-alpine AS build
WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g npm@latest && npm install -g pnpm@latest

RUN pnpm install

COPY . .

RUN pnpm run build

FROM node:23-alpine
WORKDIR /app

RUN npm install -g pnpm

COPY --from=build /app/dist /app

RUN npm install -g serve

EXPOSE 8080
CMD ["serve", "-s", "/app", "-l", "8080"]
