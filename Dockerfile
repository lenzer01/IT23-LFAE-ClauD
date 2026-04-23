FROM nginx:latest

# Copy the index.html file to the nginx html directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Default command to start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
