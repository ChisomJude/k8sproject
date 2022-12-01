#!/usr/bin/env bash


# Build image and add a descriptive tag
docker build -t chisomjude/simpleflaskapp .

# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run flask app
docker run -d -p 5000:5000 chisomjude/simpleflaskapp

#push to dockerhub
docker push chisomjude/simpleflaskapp
