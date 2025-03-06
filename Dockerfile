FROM python

WORKDIR /app

COPY . /app

CMD [ "python", "rng.py" ]

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

