FROM ros:melodic

# Install additional dependencies
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential \
#     cmake \
#     libzmqpp-dev \
#     libopencv-dev \
#     python3.6 pip3 \
#     && rm -rf /var/lib/apt/lists/

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
    && pip install catkin-tools\
    && pip install protobuf==3.0.0\
    && pip3 install catkin_pkg

# Create a catkin workspace
RUN mkdir -p ~/catkin_ws/src
WORKDIR /root/catkin_ws
RUN /opt/ros/melodic/env.sh catkin config --init --mkdirs --extend /opt/ros/melodic --merge-devel --cmake-args -DCMAKE_BUILD_TYPE=Release
RUN catkin build

RUN apt-get update && apt-get install -y \
    && pip3 install setuptools_scm \ 
    && pip3 install setuptools

# make python 3 default int

# RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
# #RUN pip install torch==1.7.1+cpu torchvision==0.8.2+cpu torchaudio==0.7.2 -f https://download.pytorch.org/whl/cpu/torch_stable.html
# RUN pip install tensorflow-gpu==1.12 scikit-build
# #RUN opencv-python==4.5.5.64\ 3 install opencv-python==4.5.5.64


# # build the environment
# RUN cd flightlib && pip install . \
#     cd ~/catkin_ws && catkin build \
#     && rm -rf/var/lib/apt/lists 

# source 
RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc 
RUN echo "export FLIGHTMARE_PATH=~/catkin_ws/src/flightmare" >> ~/.bashrc
CMD ["/bin/bash"]






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