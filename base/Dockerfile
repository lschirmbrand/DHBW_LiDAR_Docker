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
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO

# install git
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y --no-install-recommends git

# install rplidar, ydlidar & hectorslam
WORKDIR /schwarmroboter_ws/src
RUN git clone https://github.com/robopeak/rplidar_ros.git
RUN git clone https://github.com/YDLIDAR/ydlidar_ros_driver.git
RUN git clone https://github.com/tu-darmstadt-ros-pkg/hector_slam.git

# install adapted hector_slam files
WORKDIR /schwarmroboter_ws
RUN git clone https://github.com/lschirmbrand/hector_slam_dhbw.git

# copy adapted files
RUN rm src/hector_slam/hector_mapping/launch/mapping_default.launch
RUN cp hector_slam_dhbw/srcs/mapping/mapping_default_rplidar.launch src/hector_slam/hector_mapping/launch
RUN rm src/hector_slam/hector_slam_launch/launch/tutorial.launch
RUN cp hector_slam_dhbw/srcs/mapping/mapping_default_ydlidar.launch src/hector_slam/hector_mapping/launch
RUN cp hector_slam_dhbw/srcs/launching/dhbw_mapping_headless.launch src/hector_slam/hector_slam_launch/launch/dhbw_mapping.launch
RUN rm src/rplidar_ros/launch/view_rplidar_a3.launch
RUN rm src/rplidar_ros/launch/view_rplidar.launch
RUN rm -v src/ydlidar_ros_driver/launch/*
RUN cp hector_slam_dhbw/srcs/launching/dhbw_mapping_x4.launch src/ydlidar_ros_driver/launch

# install necessary ros extensions
RUN sudo apt-get install ros-noetic-tf -y
RUN sudo apt-get install libeigen3-dev -y
RUN sudo apt-get install ros-noetic-cv-bridge -y
RUN sudo apt-get install ros-noetic-image-transport -y
RUN sudo apt-get install ros-noetic-laser-geometry -y
RUN sudo apt-get install qt5-default -y

# Install YDLIDAR driver/sdk
WORKDIR /schwarmroboter_ws
RUN git clone https://github.com/YDLIDAR/YDLidar-SDK.git
WORKDIR /schwarmroboter_ws/YDLidar-SDK/build
RUN cmake ..
RUN make
RUN sudo make install

# build catkin workspace
WORKDIR /schwarmroboter_ws
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && \
    catkin_make_isolated -j1"

# Create permanent ROS enviroment variables
RUN echo "source ~/../schwarmroboter_ws/devel_isolated/setup.bash" >> ~/.bashrc