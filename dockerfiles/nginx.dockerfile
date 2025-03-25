# *Sidenote* - By adding this dockerfile we ensure that we always copy in a snapshot of our configuration and or our 
# source code into the image and we're not relying on just the bind mount from the 'docker-compose.yaml'

FROM nginx:stable-alpine

# *Sidenote* - Most casees when we nginx it'll be installed with the configuration file being found in the etc directory

# We set our working directory to '/etc/nginx/conf.d' folder
WORKDIR /etc/nginx/conf.d

# So now we can copy our local machine configuration file - this nginx.conf and the nginx folder into that working directory in 
# the container: '/etc/nginx/conf.d'. So we copying nginx folder that hold the configuration with nginx.conf file to our working
# direcotry
COPY nginx/nginx.conf .

# Since our config file named nginx.conf and it should be named default.conf inside the container because that is 
# what nginx expects there, we run a command to rename the nginx.conf to the default.conf with mv (move) command
# which is available on Linux on which this container runs.
# Also we could rename the nginx.conf to default.conf in our local machine in nginx folder
RUN mv nginx.conf default.conf

# Here we do the same with mv (move) command by rename the etc/nginx/conf.d/nginx.conf file
# RUN mv etc/nginx/conf.d/nginx.conf

# We switch our working directory to: '/var/www/html'
WORKDIR /var/www/html

# And copy our source folder to our working directory
COPY src .

# *Sidenote* - we don't need to specify here an ENTRYPOINT or a CMD (command) in this dockerfile, because the nginx image
# already has a default command, and if we don't specify our own one, the default one will be executed, and that will be 
# the one to start this web server