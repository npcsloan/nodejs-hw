FROM node:14-alpine as build

WORKDIR /app

COPY package*.json ./

COPY . .

RUN npm install

RUN npm run build

# Stage 2
FROM nginx as final

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]