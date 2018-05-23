export DOCKER_ID_USER=$USER

# Push to docker
docker login
 
# Final image
docker push $DOCKER_ID_USER/rdock
