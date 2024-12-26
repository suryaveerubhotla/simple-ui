#!/bin/bash

# Ensure the target directory exists
mkdir -p /home/ubuntu/GOCD

# Copy the JAR file from the workspace to the target directory
cp HelloWorld.jar /home/ubuntu/GOCD/

# Set permissions on the JAR file (optional but recommended)
chmod 755 /home/ubuntu/GOCD/HelloWorld.jar

# Output a success message
echo "JAR file has been deployed to /home/ubuntu/GOCD"
