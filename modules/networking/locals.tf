locals {
  pri_sub_names = data.aws_availability_zones.azs.names // give the no of azs availables in that region
  public_netnum = length(local.pri_sub_names)
  pub_sub_ids   = aws_subnet.public.*.id    // give the no of public subnet
  pri_sub_ids   = aws_subnet.private.*.id   // give the no of private subnet
}