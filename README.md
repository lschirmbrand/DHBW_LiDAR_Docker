## Manual

#### Install the Repository
Navigate trough the terminam to the wanted directory. (e.g. ``cd ~/this/that/here``)
Clone the repository into the directory with ```git clone https://github.com/lschirmbrand/DHBW_SR_Docker``

#### Build der Dockerimage
Navigate inside the cloned repository, standard case would be ``cd DHBW_SR_Docker``
After that, start the build, which creates the docker image. This you do by running:
``docker build -t lidar_testing .``

#### Running the Dockerimage / Creating the container
First, make sure the lidar was plugged in correctly by typing ``lsusb`` into the terminal. The name of the lidar should be popping up.

After you found the lidar plugged in, run ``sudo chmod 666 /dev/ttyUSB0`` to pass the necessary permisions to the lidar.

The docker container itself doesn't have any graphical display, so you have to pass yours by typing ``xhost +``.
**Notice**: You offer your display to everyone, so you should run ``xhost -`` after you run the container. You can also specify which machine is allowed to access your display.

Now you can finally run the container by typing:
``docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/ttyUSB0 lidar_testing bash``

This opens a terminal instance of the container. For ROS you need more than one terminal instance, so you have to open more terminals, what you can do by typing:
``docker exec -it name bash``

In every terminal you want to run anything ros-related, you have to first source the directory by typing:
``source devel/setup.bash``
(inside the workspace).