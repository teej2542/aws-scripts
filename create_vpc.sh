#!/usr/bin/env bash

# Ex usage: ./create_vpc.sh 172.0.0.0/16 172.0.1.0/24
VPC_CIDR_BLOCK="$1"
SUBNET_CIDR_BLOCK="$2"

VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR_BLOCK --query 'Vpc.VpcId' --output text)
echo "Waiting until the VPC comes out of PENDING state"

while state=$(aws ec2 describe-vpcs --vpc-ids $VPC_ID --output text --query 'Vpcs[0].State'); test "$state" = "pending"; do
  sleep 1; echo -n '.'
done; echo " $state"

echo "VPC $VPC_ID created"

echo "Creating subnets...."
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR_BLOCK --query 'Subnet.SubnetId' --output text)
echo "Subnet $SUBNET_ID created"

AVAILABLE_IP_ADDRESSES=$(aws ec2 describe-subnets --subnet-id $SUBNET_ID --query 'Subnets[*].AvailableIpAddressCount' --output text)
echo "Available IP Addresses: $AVAILABLE_IP_ADDRESSES"