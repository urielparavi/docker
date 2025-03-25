# We pick slim image with everything we need. 
# php-fpm - We need this for the Nginx fonfig we're using
FROM php:7.4-fpm-alpine

# We set our root/working direcotory 
# '/var/www/html' - This standard folder on web servers to serve our website from. 
WORKDIR /var/www/html

# We copying the src folder to our working directory /var/www/html for doployment to ensure that we always copy in a 
# snapshot of our configuration and or our source code into the image and we're not relying on just the bind mount from
# the 'docker-compose.yaml'
COPY src .

# We running a command for installing extra dependencies which we need
# docker-php-ext-install - Tool that help us to install the extra dependencies and we install the pdo and pdo_mysql
# extensions, and these are our PHP extensions which we need
RUN docker-php-ext-install pdo pdo_mysql


# We don't have a command (CMD) or ENTRYPOINT here, since if we don't have them, then the command (CMD) or ENTRYPOINT 
# of the base image will be used if it has any, and this php base image will have a default command which is executed
# which in the end is a command that invokes the PHP interpreter. So this image will automatically run this default
# command of the base image and therefore it will be able to deal with incoming PHP files that should be interpreted,
# because our base image is invoking this interpreter


# Since once the container is generally able to read and write, this image restricts read and write access by the container.
# This wasn't a problem with the bind mount which we used before, but it's a problem if we work only inside of the container
# as we'll do in the deployment.

# So we give our container write access to certain folders to be precise to our source code folder, our working directory:
# '/var/www/html', and we do this by running a RUN command inside of the image when it's being created and that's the 'chown'
# command, which is a Linux command for changing folder ownership and controlling who's allowed to read or write to folders,
# and we wanna add the -R flag here which in the end is just as needed to changed the ownership of an entire folder by doing
# it recursively for all folders and files of it, and we need to give a special user more premissions and that special user
# is: 'www-data' which is the default user created by this php image, and that's is the default user who by default has no
# write access to this working directory. So we need to repeat that user name, and specify the folder name '/var/www/html'
RUN chown -R www-data:www-data /var/www/html



