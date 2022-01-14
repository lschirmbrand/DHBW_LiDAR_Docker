FROM ros:noetic-ros-core-focal

LABEL Luca Schirmbrand

ARG DEBIAN_FRONTEND=noninteractive

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python3-rosdep \
    python3-rosinstall \
    python3-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO
	rosdep update

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-base=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install git
RUN apt-get update && apt-get install -y --no-install-recommends \
    && apt-get -y install git 

# install ros & hectorslam
WORKDIR /schwarmroboter_ws/src
RUN git clone https://github.com/robopeak/rplidar_ros.git
RUN git clone https://github.com/tu-darmstadt-ros-pkg/hector_slam.git

# install necessary ros extensions
RUN rosdep install -y --from-paths . -i

# install adapted hector_slam files
WORKDIR /schwarmroboter_ws
RUN git clone https://github.com/lschirmbrand/hector_slam_dhbw.git

# copy adapted files
#RUN rm src/hector_slam/hector_mapping/launch/mapping_default.launch
#RUN cp hector_slam_dhbw/srcs/mapping/mapping_default.launch src/hector_slam/hector_mapping/launch
#RUN rm src/hector_slam/hector_slam_launch/launch/tutorial.launch
#RUN cp hector_slam_dhbw/srcs/launching/tutorial.launch src/hector_slam/hector_slam_launch/launch

# build catkin workspace
WORKDIR /schwarmroboter_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    catkin_make_isolated -j1"

# Install vnc, xvfb in order to create a 'fake' display
RUN apt-get -y install \
    libcanberra-gtk-module \
    libcanberra-gtk3-module
RUN apt-get clean
