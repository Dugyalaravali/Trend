# Use nginx web server
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy production build
COPY dist/ /usr/share/nginx/html/

# Expose port 80 inside container
EXPOSE 80
