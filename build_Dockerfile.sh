# To build this image, source the file

## Build ending image updating rdock
docker build -t $USER/rdock  .

## Docker rdock run
#alias drd='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD":/home/jovyan/work --name rdock $USER/rdock'
alias drd='docker run -ti --rm -p 8888:8888 -e DISPLAY=$(ifconfig|grep "inet "|grep -v 127.0.0.1|cut -d" " -f2):0 -v /tmp/.X11-unix:/tmp/.X11-unix -v "${PWD}/../wcc_pdbbind_data":/home/jovyan/work --name rdock $USER/rdock'

## Execute in Docker rdock when running
alias drde='docker exec -it rdock'

# See images
docker images "$USER/rdock" | grep -v "none"
