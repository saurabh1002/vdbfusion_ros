FROM osrf/ros:noetic-desktop-full
LABEL maintainer="Ignacio Vizzo <ivizzo@uni-bonn.de>"

# Install utilities
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Python3 utils
RUN python3 -m pip install --no-cache  catkin-tools

# Add user to sahre files and folder without root permissions
ENV GROUP_ID=1000
ENV USER_ID=1000
RUN addgroup --gid $GROUP_ID user && adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID ipb_car
USER user

# Build ROS workspace, bash needs the "-l" to load the /etc/profile
WORKDIR /home/user/ros_ws

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash", "--login"]