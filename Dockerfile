# Set the base image to Nginx
FROM nginx:stable-alpine

# Set the maintainer (optional)
LABEL maintainer="Bhupendra-Sarkar <bsarkar2103@gmail.com>"

# Copy the static HTML files to the Nginx default web directory
COPY /public-html/ /usr/share/nginx/html/

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Expose the default Nginx port
EXPOSE 80

# Set the default command to run when starting the container
CMD ["nginx", "-g", "daemon off;"]
