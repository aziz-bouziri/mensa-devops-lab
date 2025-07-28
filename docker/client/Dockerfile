# Build stage
FROM node:18-alpine AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM nginx:stable-alpine
COPY --from=build /usr/src/app/public /usr/share/nginx/html
EXPOSE 80