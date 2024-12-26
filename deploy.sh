#!/bin/bash

# Define variables
TARGET_DIR="/home/ubuntu/GOCD"
WORKSPACE="/var/lib/go-agent/pipelines/JarDeploymentPipeline"

# Ensure the deploy.sh script is executable
if [ ! -x "${WORKSPACE}/deploy.sh" ]; then
  echo "Making deploy.sh executable..."
  chmod +x "${WORKSPACE}/deploy.sh"
fi

# Create the target directory if it doesn't exist
echo "Creating directory: ${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

# Update ownership of the target directory
echo "Setting ownership of ${TARGET_DIR} to user 'go'"
sudo chown -R go:go "${TARGET_DIR}"

# Copy the JAR file to the target directory
echo "Copying HelloWorld.jar to ${TARGET_DIR}"
cp "${WORKSPACE}/HelloWorld.jar" "${TARGET_DIR}/"

# Set permissions on the JAR file
echo "Setting permissions on ${TARGET_DIR}/HelloWorld.jar"
chmod 755 "${TARGET_DIR}/HelloWorld.jar"

# Output success message
echo "JAR file has been deployed to ${TARGET_DIR}"
