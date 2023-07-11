# # 679593333241  account ID belongs to the official CentOS Amazon Machine Image (AMI) 
# tried with centos as it is aws market place getting error
# data "aws_ami" "centos" {
#   most_recent = true
#   owners      = ["679593333241"]

#   filter {
#     name   = "name"
#     values = ["CentOS Linux 7"]
#     //values = ["CentOS 7*"]
#     // when we search for the centos 7 image in the aws market place we get the name as CentOS 7*
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }
# # it can called with data.aws_ami.centos.id
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}