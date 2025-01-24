#!/bin/bash

# Exporting environment variables
export BUILD_DIR=/home/ubuntu/builds
export BE_TARGET_DIR=/home/ubuntu/prime-square
export BE_ARCHIVE_DIR=/home/ubuntu/archive
export SERVICE=PrimeSquare.service
export SFTP_HOST=172.16.7.116
export SFTP_USER=surya
export SFTP_KEY=/var/go/.ssh/id_rsa
export SFTP_UPLOADS_DIR=uploads
export BUILD_FILE="ps_be_1.1.26_idfc_1.1.13-8b07db6-319.zip"
export BACKUP_DIR=/home/ubuntu/prime-square-backup