FROM ros:melodic


RUN apt-get update && apt-get install -y --no-install-recommends \
    lsb-release \
    build-essential \
    python3 python3-dev python3-pip \
    cmake \
    ros-melodic-rqt-gui\
    ca-certificates \
    libzmqpp-dev \
    libopencv-dev \
    gnupg2 \
    libeigen3-dev\
    git\
    && rm -rf /var/lib/apt/lists/*

# RUN install eigen \
#     apt-get install libeigen3-dev

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

# Make sure protobuf compiler version is 3.0.0 (ROS Melodic comes with this version)

# Install catkin tools
RUN apt-get update && apt-get install -y python-pip \
    python-catkin-tools\
    && pip install catkin-tools\
    && pip install protobuf==3.0.0\
    && pip3 install catkin_pkg

# Create a catkin workspace
RUN mkdir -p ~/catkin_ws/src
WORKDIR /root/catkin_ws
RUN /opt/ros/melodic/env.sh catkin config --init --mkdirs --extend /opt/ros/melodic --merge-devel --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN apt-get update && apt-get install -y \
    && pip3 install setuptools_scm \ 
    && pip3 install setuptools

# download all dependencies 
# WORKDIR /root/catkin_ws/src
# RUN git clone https://github.com/catkin/catkin_simple.git /root/catkin_ws/src/catkin_simple
# RUN git clone https://github.com/ethz-asl/eigen_catkin.git /root/catkin_ws/src/eigen_catkin
# RUN git clone https://github.com/ethz-asl/mav_comm.git /root/catkin_ws/src/mav_comm
# RUN git clone https://github.com/ethz-asl/rotors_simulator.git /root/catkin_ws/src/rotors_simulator
# RUN git clone https://github.com/uzh-rpg/rpg_quadrotor_common.git /root/catkin_ws/src/rpg_quadrotor_common
# RUN git clone https://github.com/uzh-rpg/rpg_single_board_io.git /root/catkin_ws/src/rpg_single_board_io
# RUN git clone https://github.com/uzh-rpg/rpg_quadrotor_control.git /root/catkin_ws/src/rpg_quadrotor_control


# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
# #RUN pip install torch==1.7.1+cpu torchvision==0.8.2+cpu torchaudio==0.7.2 -f https://download.pytorch.org/whl/cpu/torch_stable.html
# RUN pip install tensorflow-gpu==1.12 scikit-build
# #RUN opencv-python==4.5.5.64\ 3 install opencv-python==4.5.5.64


# # build the environment
# RUN cd flightlib && pip install . \
#     cd ~/catkin_ws && catkin build \
#     && rm -rf/var/lib/apt/lists 

# source 
WORKDIR /root/catkin_ws
RUN catkin build
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc 
RUN echo "export FLIGHTMARE_PATH=~/catkin_ws/src/flightmare" >> ~/.bashrc
CMD ["/bin/bash"]
