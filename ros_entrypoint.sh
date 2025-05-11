#!/bin/bash
set -e

sudo /RosDock/agentbuild.sh


exec "$@"
