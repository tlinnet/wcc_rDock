# To build this image, source the file

# Build with python
docker build -t $USER/rdock:02_rdock -f Dockerfile_02_rdock .
alias dr2='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name rdock02 $USER/rdock:02_rdock'
