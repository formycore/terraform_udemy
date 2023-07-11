resource "aws_instance" "myec2vm" {
  ami = data.aws_ami.amzlinux2
  // instance_type = var.instance_type this is for only single value
  // instance_type = var.instance_type_list[1] this is for list 1 indicates the array mentioned in 
  // list of instance_type_list in variables
  // instance_type = var.instance_type_map["dev"] this is for map, from the variables instance_type_map
  // we have mentioned key value pair here we have given for the value of dev
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc_ssh, aws_security_group.vpc_web]
  count = 2
  tags = {
   "Name" = "Demo-${count.index}" 
  }
}