# Use Node.js base image
FROM node:18 as build

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the frontend
RUN npm run build

# Use Nginx to serve static files
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]