FROM ros:noetic-ros-core-focal@sha256:e66897669f09dd7c3d68ea4c4fe34df26ca125964acb093d94837a7b2e1f8475

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

# install git
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y --no-install-recommends git

# install ros & hectorslam
WORKDIR /schwarmroboter_ws/src
RUN git clone https://github.com/robopeak/rplidar_ros.git
RUN git clone https://github.com/tu-darmstadt-ros-pkg/hector_slam.git


# install adapted hector_slam files
WORKDIR /schwarmroboter_ws
RUN git clone https://github.com/lschirmbrand/hector_slam_dhbw.git

# copy adapted files
RUN rm src/hector_slam/hector_mapping/launch/mapping_default.launch
RUN cp hector_slam_dhbw/srcs/mapping/mapping_default.launch src/hector_slam/hector_mapping/launch
RUN rm src/hector_slam/hector_slam_launch/launch/tutorial.launch
RUN cp hector_slam_dhbw/srcs/launching/dhbw_mapping_headless.launch src/hector_slam/hector_slam_launch/launch/dhbw_mapping.launch
RUN rm src/rplidar_ros/launch/view_rplidar_a3.launch
RUN rm src/rplidar_ros/launch/view_rplidar.launch

# install necessary ros extensions
RUN sudo apt-get install ros-noetic-tf -y
RUN sudo apt-get install libeigen3-dev -y
RUN sudo apt-get install ros-noetic-cv-bridge -y
RUN sudo apt-get install ros-noetic-image-transport -y
RUN sudo apt-get install ros-noetic-laser-geometry -y
RUN sudo apt-get install qt5-default -y

# build catkin workspace
WORKDIR /schwarmroboter_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    catkin_make_isolated -j1"