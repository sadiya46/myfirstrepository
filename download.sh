#!/bin/bash

MESSAGE="
########################################
Downloading S3 Objects into local Folder
########################################
"
echo $MESSAGE

TARGET="/home/ubuntu/S3-Download"
SOURCE=s3:"//s3-bucket-mi"
DIR="/home/ubuntu/S3-Download"

if [ -d $DIR ]
then
echo "Checking Object in the S3 Bucket"

else
mkdir "$DIR"
echo " the new directory has been successfully created:  $DIR"

fi

aws s3 sync $SOURCE $TARGET 

MESSAGE2="
########################################
S3 objects downloaded successfully into local folder
########################################
"
echo $MESSAGE2
