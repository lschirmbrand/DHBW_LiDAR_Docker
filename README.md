# DHBW_SR_Docker

lsusb
sudo chmod 666 /dev/ttyUSB0
docker run -t -i --device=/dev/ttyUSB0 ubuntu bash

docker exec -it name bash
source devel/setup.bash