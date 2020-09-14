# Source the official nginx repository
FROM nginx:alpine

# Copy file to the directory
COPY index.html /usr/share/nginx/html 

# Expose the port for HTTP
EXPOSE 80 