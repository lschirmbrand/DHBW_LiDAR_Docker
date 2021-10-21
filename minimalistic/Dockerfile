FROM ubuntu
LABEL Luca Schirmbrand

ARG DEBIAN_FRONTEND=noninteractive

FROM ros:noetic-ros-core-focal

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

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-ros-base=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install git
RUN apt-get update && apt-get install -y --no-install-recommends \
    && apt-get -y install git 

WORKDIR /schwarmroboter_ws/src
RUN git clone https://github.com/robopeak/rplidar_ros.git

WORKDIR /schwarmroboter_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    catkin_make"
