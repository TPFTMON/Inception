# Use the penultimate stable version of Debian
FROM debian:bookworm

# Update package lists and install NGINX and OpenSSL
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Create a directory to store the SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Auvergne-Rhone-Alpes/L=Lyon/O=42/OU=42/CN=wil.42.fr/UID=wil"

# Copy the custom NGINX configuration file from the host to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Document that this container will listen on port 443
EXPOSE 443

# Start NGINX in the foreground when the container launches
CMD ["nginx", "-g", "daemon off;"]