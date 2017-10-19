#!/bin/bash

date
echo "Args: $@"
env
echo "This is my simple test job!."
echo "jobId: $AWS_BATCH_JOB_ID"
aws s3 cp s3://freesurfer-bucket/yujiang.nii 002.nii
aws s3 cp 002.nii s3://002.nii
sleep $1
date
echo "bye bye!!"
