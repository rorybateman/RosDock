#!/bin/bash
set -e

#sudo /RosDock/agentbuild.sh

#!/bin/bash

source /opt/ros/foxy/setup.bash

source /microros_ws/install/local_setup.bash

ros2 run micro_ros_setup create_agent_ws.sh

ros2 run micro_ros_setup build_agent.sh


tail -f /dev/null

exec "$@"