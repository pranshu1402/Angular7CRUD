# Create image based on the official Node 14 image from dockerhub
FROM node:14 as build-step

# Create a directory where our app will be placed
RUN mkdir -p /app

# Change directory so that our commands run inside this new directory
WORKDIR /app

# Copy dependency definitions
COPY package*.json /app/

# Install dependecies
RUN npm install

# Get all the code needed to run the app
COPY . /app/

# Serve the app
RUN npm run build

# Serve the build content using nginx
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/webapp /usr/share/nginx/html
# COPY ./nginx/client_nginx.conf /etc/nginx/nginx.conf

EXPOSE 80