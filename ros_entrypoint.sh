#!/bin/bash
set -e

# Source ROS 2 environment
source /opt/ros/foxy/setup.bash

# Source micro-ROS tools
source /microros_ws/install/local_setup.bash
ros2 run micro_ros_setup create_agent_ws.sh
ros2 run micro_ros_setup build_agent.sh
source install/local_setup.bash


exec "$@"
