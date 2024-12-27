#!/bin/bash

# Define variables
TARGET_DIR="/home/ubuntu/GOCD"
WORKSPACE="/var/lib/go-agent/pipelines/JarDeploymentPipeline"

# Ensure the deploy.sh script is executable
if [ ! -x "${WORKSPACE}/deploy.sh" ]; then
  echo "Making deploy.sh executable..."
  chmod +x "${WORKSPACE}/deploy.sh"
fi

# Update ownership of the target directory
echo "Setting ownership of ${TARGET_DIR} to user 'go'"
if ! sudo chown -R go:go "${TARGET_DIR}"; then
  echo "ERROR: Unable to change ownership of ${TARGET_DIR}. Check permissions."
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
if ! cp "${WORKSPACE}/HelloWorld.jar" "${TARGET_DIR}/"; then
  echo "ERROR: Unable to copy HelloWorld.jar to ${TARGET_DIR}."
  exit 1
fi

# Set permissions on the JAR file
echo "Setting permissions on ${TARGET_DIR}/HelloWorld.jar"
if ! chmod 755 "${TARGET_DIR}/HelloWorld.jar"; then
  echo "ERROR: Unable to set permissions on HelloWorld.jar."
  exit 1
fi

# Output success message
echo "JAR file has been deployed to ${TARGET_DIR}"
