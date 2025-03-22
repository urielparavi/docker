# We pick slim image with everything we need. 
# php-fpm - We need this for the Nginx fonfig we're using
FROM php:7.4-fpm-alpine

# We set our root/working direcotory 
# '/var/www/html' - This standard folder on web servers to serve our website from. 
WORKDIR /var/www/html

# We running a command for installing extra dependencies which we need
# docker-php-ext-install - Tool that help us to install the extra dependencies and we install the pdo and pdo_mysql
# extensions, and these are our PHP extensions which we need
RUN docker-php-ext-install pdo pdo_mysql


# We don't have a command (CMD) or ENTRYPOINT here, since if we don't have them, then the command (CMD) or ENTRYPOINT 
# of the base image will be used if it has any, and this php base image will have a default command which is executed
# which in the end is a command that invokes the PHP interpreter. So this image will automatically run this default
# command of the base image and therefore it will be able to deal with incoming PHP files that should be interpreted,
# because our base image is invoking this interpreter