export DOCKER_ID_USER=$USER

# Push to docker
docker login
 
# Image 1
docker push $DOCKER_ID_USER/rdock:01_packages

# Image 2
docker push $DOCKER_ID_USER/rdock:02_rdock

# Final image
#docker tag $USER/rdock $DOCKER_ID_USER/rdock
docker push $DOCKER_ID_USER/rdock
