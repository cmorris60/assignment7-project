
FROM fedora:latest

# Install Apache HTTP Server
RUN dnf -y install httpd && dnf clean all

# Create the structure folder as root
USER root
RUN mkdir -p /structure && chmod 777 /structure

# Create the sync-work folder as sync
USER sync
RUN mkdir /structure/sync-work

# Create the nobody-work folder as nobody
USER nobody
RUN mkdir /structure/nobody-work

# Create the collin user
USER root
RUN useradd -m collin

# Create the website index.html file
RUN echo "Containers are easy!" > /var/www/html/index.html

# Expose port 80
EXPOSE 80

# Run Apache as root
USER root
ENTRYPOINT /usr/sbin/httpd -DFOREGROUND
