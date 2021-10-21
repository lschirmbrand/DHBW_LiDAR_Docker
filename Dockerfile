FROM ubuntu:20.04
LABEL Luca Schirmbrand
SHELL ["/bin/bash", "-cl"] 

WORKDIR /schwarmroboter_ws/src
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt-get -y install git
RUN apt-get install -y lsb-release
RUN apt-get update && apt-get install -y gnupg2
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F42ED6FBAB17C654
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-get -y install curl
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update
RUN apt-get -y install ros-noetic-ros-base
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN source ~/.bashrc
RUN git clone https://github.com/robopeak/rplidar_ros.git
RUN apt-get install ros-noetic-catkin
RUN apt-get install cmake
WORKDIR /schwarmroboter_ws
# RUN bash catkin_make