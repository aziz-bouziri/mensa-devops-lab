# Build stage
FROM node:22-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM nginx:1.29
COPY --from=build /usr/src/app/public /usr/share/nginx/html
EXPOSE 80