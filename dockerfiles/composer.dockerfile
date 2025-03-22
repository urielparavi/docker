FROM composer:latest

WORKDIR /var/www/html

# *Sidenote* - We need custom Dockerfile and not the default imaged, because we want to specify an entrypoint, 
# and actually we can to it in the docker-compose file as well, but we doing it here in the Dockerfile, since it's more 
# clear and easy to understand.
# So the entrypoint is the composer which exists inside of this composer image and container and we install here the Laravel
# dependencies.
# "--ignore-platform-reqs" - This ensure that we can run this without any warnings, errors even if some dependencies
# would be missing 
ENTRYPOINT [ "composer", "--ignore-platform-reqs" ]


# ENTRYPOINT - It's similar to the command (CMD) instruction, but it has one key difference. If we add a command
# after the image name on docker run, for example: 'docker run -it -v "%cd%":/app node-util npm install', then it 
# wil overwrite the command (CMD) specified in a Dockerfile if there is one. 
# With ENTRYPOINT that's different - For the entrypoint whatever we enter in docker run, for example:
# 'docker run -it -v "%cd%":/app node-util npm install', is appended after the entrypoint, so we can specify
# 'npm' and now we could append any 'npm' command after our image name for example, with npm -
#  'docker run -it -v "%cd%":/app node-util npm'