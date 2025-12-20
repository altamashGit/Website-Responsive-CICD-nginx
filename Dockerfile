# Use the official Nginx image as the base
FROM nginx:alpine

# Set the working directory to Nginx asset directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static assets
RUN rm -rf ./*

# Copy the static files from your repo to the container
# This assumes your HTML/CSS/JS files are in the root of your repo
COPY . .

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]
