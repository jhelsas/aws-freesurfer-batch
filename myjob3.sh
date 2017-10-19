#!/bin/bash

date
echo "Args: $@"
env
echo "This is my simple test job!."
echo "jobId: $AWS_BATCH_JOB_ID"
source /opt/freesurfer/FreeSurferEnv.sh
export SUBJECTS_DIR=/output
cd /output
aws s3 cp s3://freesurfer-bucket/yujiang.nii teste.nii
echo "begining recon-all"
recon-all -subjid teste -i teste.nii -all
zip -r teste.zip teste
echo "begining recon-all"
aws s3 cp teste.zip s3://freesurfer-bucket/teste.zip
date
echo "bye bye!!"
