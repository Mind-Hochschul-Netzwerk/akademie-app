FROM node:alpine as build-deps
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:latest
COPY nginx/ /etc/nginx/
COPY --from=build-deps /usr/src/app/dist /var/www/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
