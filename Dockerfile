FROM osrf/ros:foxy-desktop

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=foxy

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-pip \
    git \
    build-essential \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists/*

# Install rosdep using pip
RUN pip3 install -U rosdep 

RUN /bin/bash -c "git clone https://github.com/rorybateman/RosDock.git &&\
    cd RosDock && \
    chmod +x /RosDock/agentbuild.sh && \
    /RosDock/agentbuild.sh"

    


