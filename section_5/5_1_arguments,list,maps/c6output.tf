# Terraform Output Values
# ------------------------- Public IP ----------------------------------
# output "instance_public_ip" {
#   description = "Public ip"
#   value = aws_instance.myec2vm.public_ip    
# }
output "for_instance_list" {
  description = "for loop with list"
  # value = [for instance in resource:value]
  value = [for instance in aws_instance.myec2vm: instance.public_ip]
  // here we are looking for the instances aws_instance.myec2vm
  // it does not matter how many are there we will get the public_ip 
  // suppose if we have two aws_instance.myec2vm it will run for 2 times 
  // for the first time aws_instance.myec2vm value will be in instance then we first instance public_ip
  // and for the second time aws_instance.myec2vm value will be in instance then we get the second instance public_ip
  
}
# # ---------------------------- Public DNS --------------------------------
# output "instance_public_dns" {
#   description = "public dns"
#   value = aws_instance.myec2vm.public_dns
# }
# # -------------------------- Private_IP ----------------------------
# output "instance_private_ip" {
#   value = aws_instance.myec2vm.private_ip
# }
# # ----------------------- private_dns---------------------------
# output "instance_private_dns" {
#   value = aws_instance.myec2vm.private_dns
# }
output "for_output_map1" {
  description = "for loop with map"
  # this instance.id is the key and instance.public_dns is the value
  # is instance.id is anything we need to assign as the key
  # value = {for instance in resource:value key => value}} 
  value = {    for instance in aws_instance.myec2vm: instance.id => instance.public_dns   }
}
output "for_output_map2" {
  description = "for loop with map"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}
# output "for loop with map advanced" {
#   description = "For Loop with Map - Advanced"
#   value = {for c, instance in resource:value key => value}} 
#   value = {
#     for c, instance in aws_instance.myec2vm: c => instance.public_dns
#   } # this c is the key and instance.public_dns is the value
#   # is c is count number 
#   # if we have 3 count index then the output will be like this
#   for loop with map advanced = {
#   "0" = "ec2-3-84-111-111.compute-1.amazonaws.com",
#   "1" = "ec2-54-84-111-111.compute-1.amazonaws.com",
#   "2" = "ec2-54-84-111-111.compute-1.amazonaws.com",
#   }
# }
output "for_output_legacy_splat_operator" {
  description = "for loop with map legacy splat operator"
  # value = aws_instance.myec2vm.public_dns this is  ok for count 1 
  value = aws_instance.myec2vm.*.public_dns # for count more than 1 or 2

}

output "for_output_legacy_latest_splat_operator" {
  description = "for loop with map legacy splat operator"
  # value = aws_instance.myec2vm.public_dns this is  ok for count 1 
  value = aws_instance.myec2vm[*].public_dns # for count more than 1 or 2
  # for the respective resouce myec2vm, the local name reference of this resource
  # with the count resource <myec2vm> going to increase
}

