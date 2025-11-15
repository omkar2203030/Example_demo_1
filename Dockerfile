# Use lightweight nginx image
FROM nginx:alpine

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your website into nginx folder
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80