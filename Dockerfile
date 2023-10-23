FROM ros:melodic

# Install additional dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libzmqpp-dev \
    libopencv-dev \
    && rm -rf /var/lib/apt/lists/

# Install Gazebo
RUN apt-get update && apt-get install -y \
    gazebo9 \
    && rm -rf /var/lib/apt/lists/

# Install ROS Dependencies
RUN apt-get update && apt-get install -y \
    libgoogle-glog-dev \
    protobuf-compiler \
    ros-melodic-octomap-msgs \
    ros-melodic-octomap-ros \
    ros-melodic-joy \
    python-vcstool \
    && rm -rf /var/lib/apt/lists/

# Make sure protobuf compiler version is 3.0.0 (ROS Melodic comes with this version)

# Install catkin tools
RUN apt-get update && apt-get install -y python-pip \
    && pip install catkin-tools


# Create a catkin workspace
RUN mkdir -p catkin_ws/src
WORKDIR /catkin_ws
RUN /opt/ros/melodic/env.sh catkin config --init --mkdirs --extend /opt/ros/melodic --merge-devel --cmake-args -DCMAKE_BUILD_TYPE=Release
RUN catkin build
WORKDIR /catkin_ws/src

RUN pip install -y opencv-python== 4.5.5.64 \
    pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 -c pytorch \
    stable-baselines3\
    && rm -rf/var/lib/apt/lists 

# build the environment
RUN cd flightmare/flightlib && pip install . \
    cd ~/catkin_ws && catkin build \
    && rm -rf/var/lib/apt/lists 

# source 
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc \
    && echo "export FLIGHTMARE_PATH=~/catkin_ws/src/flightmare" >> ~/.bashrc\
    && source ~/.bashrc







# # Clone the Flightmare repository and its dependencies
# #WORKDIR catkin_ws/src
# # RUN git clone https://github.com/uzh-rpg/flightmare.git
# # Clone the catkin_simple repository
# RUN git clone https://github.com/catkin/catkin_simple.git 

# # Clone the eigen_catkin repository
# RUN git clone https://github.com/ethz-asl/eigen_catkin.git 

# # Clone the mav_comm repository
# RUN git clone https://github.com/ethz-asl/mav_comm.git 

# # Clone the rotors_simulator repository
# RUN git clone https://github.com/ethz-asl/rotors_simulator.git 

# # Clone the rpg_quadrotor_common repository
# RUN git clone https://github.com/uzh-rpg/rpg_quadrotor_common.git 

# # Clone the rpg_single_board_io repository
# RUN git clone https://github.com/uzh-rpg/rpg_single_board_io.git 

# # Clone the rpg_quadrotor_control repository
# RUN git clone https://github.com/uzh-rpg/rpg_quadrotor_control.git 

# # Build the workspace
# RUN /opt/ros/melodic/env.sh catkin build

# # Add sourcing of the catkin workspace and set FLIGHTMARE_PATH
#  RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
#  RUN echo "export FLIGHTMARE_PATH=/catkin_ws/src/flightmare" >> ~/.bashrc
#  RUN /bin/bash -c "source ~/.bashrc"