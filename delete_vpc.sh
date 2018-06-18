#!/usr/bin/env bash

VPC_ID="$1"

aws ec2 describe-subnets --query 'Subnets[*].[VpcId, SubnetId]' --output text |
grep $1 |
awk '{print $2}' |
while read line;
do aws ec2 delete-subnet --subnet-id $line;
done

echo "Subnets deleted"

aws ec2 delete-vpc --vpc-id $VPC_ID

DELETE_MESSAGE="Terminated VPC:$VPC_ID in AWS!"
echo $DELETE_MESSAGE