// gives data of the all availablility zones in that reigion
data "aws_availability_zones" "azs" {
  state = "available"
}