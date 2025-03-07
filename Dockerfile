# FROM - Allow us to build our image up on another base image. sidenote: we could build a Docker image from scratch,
# but we always want some kind of operating system layer in there, some kind of other tool which our code needs
FROM node:12

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


FROM python

WORKDIR /app

COPY . /app

CMD [ "python", "rng.py" ]


# COMMANDS

# docker build . => With the dot we tell Docker that the Dockerfile will be in the same folder as we're running this command


# DELETE IMAGES & CONTAINERS - *Sidenote* We can only remove images if we remove their containers first

# docker container prune - Allow us to delete all our stoped containers
# docker rm - Allow us to delete specific or multiple containers with their names

# docker images - Allow to see all our images

# docker image prune - Allow us to remove all our images which have not tags.
# docker image prune -a - Allow us to remove all unused images including images with the tags
# docker rmi - Allow us to remove specific or multiple images with their names

# docker system prune -a => Allow us to clean up unused images, so it's clear everything from the docker system 

# --rm - Create container and remove it automatically when it stop (more details on docker run --help)
# example: docker run -p 3000:80 -d --rm 05c377af849a

# docker image inspect 05c377af849a - Give us information about the image


# ENTERING INTERACTIVE MODE 

# In this example we illustrate a case where we only want to run software/app and not run it as a web server - so, we want 
#  to be in attached state, but in listening mode and also to be able input something, so interact with our container

# - i - t / -it => With the combining of the i and the t flags we'll able to be in listening mode, and also to input something 
# when we run our container. So the container will listen for our input, and we'll also get a terminal exposed by the 
# container, which is the device where we enter the input (for more details on -i or -t flags, check docker run --help)
# docker run -it f5396224a0d1

# If we restarting the container and we want to listen mode and also to be able to input something mode, we'll use -a -i.

# So the difference between the -it/-i -t and the -a -i, is the -it for when we running our container, and -a -i when we 
# restart our container (for more details on -a or -i flags, check docker start --help)
# docker start -a -i relaxed_grothendieck


# CP COMMAND - allow us to copy files of folders into running container or out of a running container to our local host machine

# Here we copy everything in the dummy folder from our local host machine to this container to test folder (if it not 
# exist, it will created)
# docker cp dummy/. youthful_archimedes:/test

# Here we copy from the test folder in our container to the dummy folder in our local host machine 
# docker cp youthful_archimedes:/test dummy

# Here we copy from the test folder in our container only the test.txt file to the dummy folder in our local host machine 
# docker cp youthful_archimedes:/test/test.txt dummy


# NAMING & TAGGING CONTAINERS AND IMAGES

# Here we give a name for container
# docker run -p 3000:80 -d --rm --name goalsapp 74da73ce6927 (for more details check docker run --help)

# In image, the image tags(name & tag combination) consists of two parts - the actual name (repository), and the tag. 
# so, name:tag
# So with the name we set general name, and with the tag we define a more specialized version of that image 
# For example: node:12

# We build our image and give it name of goals, and tag latest, to indicate that this is latest version of the goalsapp
# docker build -t goals:latest . (for more details check docker build --help) 

# We run and give the container name 'goalsapp' and plug in the image with the tag 'goals:latest' instead the image ID
# docker run -p 3000:80 -d --rm --name goalsapp goals:latest

# PUSHING IMAGES TO DOCKERHUB 

# *Sidenote* - if we push/pull to a private registry (other provider), we need to inlude the host, so the url of the provider
# for example - HOST:NAME

# We need to verify that this is our account for pushing images to dockerhub. 
# login

# For pushing image to dockerhub we need to create reopository and give our image the name that we set in dockerhub
# for example: urielpa/node-hello-world:tagname

# First way - create new image with that name
# docker build -t urielpa/node-hello-world .

# Second way - we reuse that image that we have already and renaming it for retaggin images
# *Sidenote* when we renaming an image, we create a clone of the old image, so the old image not deleted

# docker tag node-demo:latest urielpa/node-hello-world(:latest)
# node-demo:latest - old name, urielpa/node-hello-world - new name (we can also allocate it a tag)

# docker push urielpa/node-hello-world(:tagname)