FROM instrumentisto/flutter as build

# Set the working directory in the Docker container
WORKDIR /app

# Copy the Flutter project into the Docker container
COPY . .

# Build the Flutter web application
RUN flutter pub get
RUN flutter build web

# Use a lightweight image with a web server to serve the built application
FROM nginx:alpine

# Copy the built application from the build container to the nginx container
COPY --from=build /app/build/web/ /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]