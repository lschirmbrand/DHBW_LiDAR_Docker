# DHBW_SR_Docker
docker build -f firefox.Dockerfile -t <NAME> .

lsusb

sudo chmod 666 /dev/ttyUSB0

docker run -t -i --device=/dev/ttyUSB0 ubuntu bash

docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix <NAME>

docker exec -it name bash

source devel/setup.bash
  
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/ttyUSB0 lidartest bash
