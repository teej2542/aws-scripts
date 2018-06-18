**AWS Scripts to help build out an evironment**

<b>These scripts assume that you have the proper authenticated credentials(via aws configure)</b>

Create a VPC with a subnet by passing in two parameters (VPC CIDR Block, SUBNET CIDR Block)
<br/>
<code>./create_vpc.sh 172.0.0.0/16 172.0.1.0/24</code>

Delete VPC and it connected subnets(Pass in vpc id): <code>./delete_vpc.sh vpcID</code>