#Builder phase to build a production environment container (Quite similar to the dev one)
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

#Run phase to run the production environment using nginx
#COPY --from=build means to copy something from the builder phase above
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

