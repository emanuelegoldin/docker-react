# Build phase

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# we don't need volumes: production -> we won't change anything
# /app/build <-- has the needed stuff

# Run phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx will start our app
