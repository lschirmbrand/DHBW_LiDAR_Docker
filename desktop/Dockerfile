FROM ros:noetic-robot@sha256:0d43b3f0e23fb14a2704ff979c25d9c2710be3c671ae414e53fedc5730013d07

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
RUN #rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    rosdep update

# install git
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get install -y --no-install-recommends git 

# install rplidar, ydlidar & hectorslam
WORKDIR /schwarmroboter_ws/src
RUN git clone https://github.com/robopeak/rplidar_ros.git
RUN git clone https://github.com/YDLIDAR/ydlidar_ros_driver.git ydlidar_ws/src/ydlidar_ros_driver
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
RUN rm -v src/ydlidar_ros_driver/launch/*
RUN cp hector_slam_dhbw/srcs/launching/dhbw_mapping_x4.launch src/ydlidar_ros_driver/launch

# install necessary ros extensions
RUN rosdep install -y --from-paths . -i

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