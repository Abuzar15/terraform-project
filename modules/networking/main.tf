//create vpc
resource "aws_vpc" "myvpc" {

  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name     = "MyVPC-${terraform.workspace}"
    Environment="${terraform.workspace}"
  }

}
 // create private subnet
resource "aws_subnet" "private_subnet" {
  count             = length(local.pri_sub_names)
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = local.pri_sub_names[count.index]
  tags = {
    Name = "PrivateSubnet-${terraform.workspace}-${substr(local.pri_sub_names[count.index], 9, 2)}"
  }
}
 // create public subnet
resource "aws_subnet" "public_subnet" {
  count             = length(local.pri_sub_names)
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, local.public_netnum + count.index)
  availability_zone = local.pri_sub_names[count.index]
  tags = {
    Name = "PublicSubnet-${terraform.workspace}-${substr(local.pri_sub_names[count.index], 9, 2)}"
  }
}