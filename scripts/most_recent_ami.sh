#!/bin/bash
aws ec2 describe-images --owners 099720109477 \
                        --filters Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-* \
                        --profile terraform \
                        | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
