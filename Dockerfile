FROM osrf/ros:foxy-desktop

ENV DEBIAN_FRONTEND=noninteractive \
    ROS_DISTRO=foxy \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Install required tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    clang-tidy \
    clang-10 \
    clang-tools-10 \
    llvm-10 \
    llvm-10-dev \
    binfmt-support \
    libc6-dev \
    libc6-i386 \
    lib32gcc-s1 \
    lib32stdc++6 \
    libclang-common-10-dev \
    libclang-cpp10 \
    libgc1c2 \
    libobjc-9-dev \
    libomp-10-dev \
    libomp5-10 \
    libpfm4 \
    libpipeline1 \
    libz3-dev \
    libz3-4 \
    && rm -rf /var/lib/apt/lists/*

# Install required system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    python3-pip \
    python3-colcon-common-extensions 

# Upgrade pip tools and install rosdep
RUN pip3 uninstall -y importlib_metadata || true && \
    pip3 install --upgrade pip && \
    pip3 install 'setuptools<60' && \
    pip3 install -U rosdep


# Initialize rosdep
RUN rosdep update

# Set up micro-ROS workspace
RUN mkdir -p /microros_ws/src && \
    git clone -b ${ROS_DISTRO} https://github.com/micro-ROS/micro_ros_setup.git /microros_ws/src/micro_ros_setup

# Install micro-ROS dependencies
RUN bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && \
    cd /microros_ws && \
    rosdep install --from-paths src --ignore-src -y --skip-keys=' libasio-dev clang-tidy'"

# Build micro-ROS workspace
WORKDIR /microros_ws
RUN bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash && colcon build"

# Entrypoint
COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["bash"]
