#!/usr/bin/env bash

set -o errexit -o xtrace

aws s3api head-bucket --bucket "$1" || aws s3 mb "s3://${1}"

aws s3api put-bucket-policy --bucket "$1" \
  --policy "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":[\"s3:GetObject\",\"s3:GetObjectVersion\"],\"Resource\":\"arn:aws:s3:::${1}/*\"},{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":[\"s3:ListBucket\",\"s3:GetBucketVersioning\"],\"Resource\":\"arn:aws:s3:::${1}\"}]}" \

aws s3api put-bucket-versioning --bucket "$1"  --versioning-configuration Status=Enabled

aws s3 cp main.yml "s3://${1}"

aws s3 cp --recursive aws-infra/ "s3://${1}/aws-infra"

aws s3 cp --recursive aws-devops/ "s3://${1}/aws-devops"
