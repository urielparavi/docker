# FROM - Allow us to build our image up on another base image. sidenote: we could build a Docker image from scratch,
# but we always want some kind of operating system layer in there, some kind of other tool which our code needs
FROM node

# WORKDIR: Working directory that tells Docker that all the comands will be executed from inside that folder, so app folder 
# (in our case)
WORKDIR /app

# Since all layers changes after the changing layer, we add the package.json here, so when we'll change our source code
# (when we copy after npm install) only the subsequent instructions we'll re-execute, and then the docker we'll not run
# npm install when the source code change, since there is no need, because our dependencies not changed
COPY package.json /app

# RUN - We telling Docker after copying, to run npm install on our image for all the dependencies 
RUN npm install

# COPY - We tell Docker which files that live here on our local machine, should go into the image, and we specify two path here

# First path: path of the outside container/image where the files leave that should be copied into the image, and a dot 
# means that is the same folder that contain the Dockerfile. So, it tell Docker that all 
# folders, sub folders, files should be copie into the image

# Second path: the path inside of the image where those files should be stored. In our case, it's the sub folder app
# where all our folders/subfolders, files where the Dockerfile, so all of them will copied to /app. And if this folder not
# exist it will be created
COPY . /app

# We expose the port from our isolated conatiner to our local machine, but actually this more instruction for 
# documentation purposes, so we don't need this for run our container
EXPOSE 80

# So our node server will run when a container is started based on the image, and not the imaged itself.
# The difference between RUN and CMD, that RUN will setting up our image, but CMD will activate it on the container based
# from our image
CMD [ "node", "server.js" ]


# COMMANDS

# docker build . => With the dot we tell Docker that the Dockerfile will be in the same folder as we're running this command

# DELETE IMAGES & CONTAINERS - *Sidenote* We can only remove images if we remove their containers first

# docker container prune - Allow us to delete all our stoped containers
# docker rm - Allow us to delete specific or multiple containers with their names

# docker images - Allow to see all our images

# docker image prune - Allow us to remove all our images 
# docker rmi - Allow us to remove specific or multiple images with their names

# docker system prune -a => Allow us to clean up unused images, so it's clear everything from the docker system 


# --rm - Create container and remove it automatically when it stop (more details on docker run --help)
# example: docker run -p 3000:80 -d --rm 05c377af849a


