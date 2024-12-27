#!/bin/bash

# Define variables
TARGET_DIR="/home/ubuntu/GOCD"
WORKSPACE="/var/lib/go-agent/pipelines/JarDeploymentPipeline"

# Adjust permissions on /home/ubuntu to allow directory creation
echo "Adjusting permissions on /home/ubuntu..."
if sudo chmod 775 /home/ubuntu && sudo chown -R go:go /home/ubuntu; then
  echo "Permissions adjusted successfully."
else
  echo "ERROR: Unable to adjust permissions on /home/ubuntu. Check sudo privileges."
  exit 1
fi

# Create the target directory if it doesn't exist
echo "Creating directory: ${TARGET_DIR}"
if ! mkdir -p "${TARGET_DIR}"; then
  echo "ERROR: Unable to create directory ${TARGET_DIR}. Check permissions."
  exit 1
fi

# Copy the JAR file to the target directory
echo "Copying HelloWorld.jar to ${TARGET_DIR}"
if [ -f "${WORKSPACE}/HelloWorld.jar" ]; then
  if ! cp "${WORKSPACE}/HelloWorld.jar" "${TARGET_DIR}/"; then
    echo "ERROR: Unable to copy HelloWorld.jar to ${TARGET_DIR}."
    exit 1
  fi
else
  echo "ERROR: HelloWorld.jar not found in ${WORKSPACE}."
  exit 1
fi

# Set permissions on the JAR file
echo "Setting permissions on ${TARGET_DIR}/HelloWorld.jar"
if ! chmod 755 "${TARGET_DIR}/HelloWorld.jar"; then
  echo "ERROR: Unable to set permissions on HelloWorld.jar."
  exit 1
fi

# Output success message
echo "JAR file has been successfully deployed to ${TARGET_DIR}"
