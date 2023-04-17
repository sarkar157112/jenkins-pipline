# Use the official Nginx image as the base
FROM nginx:1.21

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration file into the image
COPY ./my-nginx.conf /etc/nginx/conf.d/my-nginx.conf

# Copy your application files into the Nginx container
COPY ./public-html/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]