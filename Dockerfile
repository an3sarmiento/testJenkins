FROM node:14-alpine as build

WORKDIR /app

COPY package.json .

RUN npm install

RUN npm install -g ionic

COPY . .

RUN ionic build --prod

FROM nginx:stable-alpine

COPY --from=build /app/www /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
