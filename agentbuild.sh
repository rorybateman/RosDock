cd ~

source /microros_ws/install/local_setup.bash

ros2 run micro_ros_setup create_agent_ws.sh

ros2 run micro_ros_setup build_agent.sh

ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0
