FROM ros:melodic


RUN apt-get update && apt-get install -y --no-install-recommends \
    lsb-release \
    build-essential \
    python3 python3-dev python3-pip \
    python3-venv\
    cmake \
    ros-melodic-rqt-gui\
    ca-certificates \
    libzmqpp-dev \
    libopencv-dev \
    gnupg2 \
    libeigen3-dev\
    git\
    && rm -rf /var/lib/apt/lists/*


# Install Gazebo
RUN apt-get update && apt-get install -y \
    gazebo9 \
    && rm -rf /var/lib/apt/lists/*

# Install ROS Dependencies
RUN apt-get update && apt-get install -y \
    libgoogle-glog-dev \
    protobuf-compiler \
    ros-melodic-octomap-msgs \
    ros-melodic-octomap-ros \
    ros-melodic-joy \
    python-vcstool \
    ros-melodic-rqt-gui-py\
    ros-melodic-gazebo-plugins\
    && rm -rf /var/lib/apt/lists/*


# # Install catkin tools
RUN apt-get update && apt-get install -y python-pip \
    python-catkin-tools\
    && pip install catkin-tools\
    && pip3 install catkin_pkg\


    # Create a virtual environment and activate it, install dependencies 

    RUN python3 -m venv /root/RL \
    && /root/RL/bin/pip install --upgrade pip\
    && /root/RL/bin/pip install wheel \
    && /root/RL/bin/pip install  protobuf==3.6.1\
    setuptools\
    tensorflow
RUN /root/RL/bin/pip install scikit-build\
    setuptools_scm \ 
    && root/RL/bin/pip install setuptools\
    && /root/RL/bin/pip install  opencv-python==4.5.5.64


# Create a catkin workspace
RUN mkdir -p ~/catkin_ws/src
WORKDIR /root/catkin_ws
RUN /opt/ros/melodic/env.sh catkin config --init --mkdirs --extend /opt/ros/melodic --merge-devel --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN apt-get update && apt-get install -y \
    && pip3 install setuptools_scm \ 
    && pip3 install setuptools
# # build the environment
# RUN cd flightlib && pip install . \
#     cd ~/catkin_ws && catkin build \
#     && rm -rf/var/lib/apt/lists 

# source 
WORKDIR /root/catkin_ws
RUN catkin build
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc 
RUN echo "export FLIGHTMARE_PATH=~/catkin_ws/src/flightmare" >> ~/.bashrc
RUN /bin/bash -c "source ~/RL/bin/activate"

