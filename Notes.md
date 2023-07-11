# Terraform For Loops, Lists, Maps and Count Meta-Argument
## Step-00: Pre-requisite Note
- We are using the default vpc in us-east-1 region
## Step-01: Introduction
- Terraform Meta-Argument: Count
- ### Terraform Lists & Maps
    - List(string)
    - map(string)
- ### Terraform for loops
    - for loop with List
    - for loop with Map
    - for loop with Map Advanced
- ### Splat Operators
    - Legacy Splat Operator .*.
    - Generalized Splat Operator (latest)
    - Understand about Terraform Generic Splat Expression [*] when dealing with count Meta-Argument and multiple output values
## Step-02: c1-versions.tf
    - No changes
## Step-03: c2-variables.tf - Lists and Maps
```
# AWS EC2 Instance Type - List
variable "instance_type_list" {
  description = "EC2 Instnace Type"
  type = list(string)
  default = ["t3.micro", "t3.small"]
}


# AWS EC2 Instance Type - Map
variable "instance_type_map" {
  description = "EC2 Instnace Type"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa"  = "t3.small"
    "prod" = "t3.large"
  }
}
```

## Step-04: c3-ec2securitygroups.tf and c4-ami-datasource.tf
    - No changes to both files
## Step-05: c5-ec2instance.tf
```

# How to reference List values ?
instance_type = var.instance_type_list[1]

# How to reference Map values ?
instance_type = var.instance_type_map["prod"]

# Meta-Argument Count
count = 2

# count.index
  tags = {
    "Name" = "Count-Demo-${count.index}"
  }
```

## Step-06: c6-outputs.tf
    - for loop with List
    - for loop with Map
    - for loop with Map Advanced
```
# Output - For Loop with List
output "for_output_list" {
  description = "For Loop with List"
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
}

# Output - For Loop with Map
output "for_output_map1" {
  description = "For Loop with Map"
  value = {for instance in aws_instance.myec2vm: instance.id => instance.public_dns}
}

# Output - For Loop with Map Advanced
output "for_output_map2" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in aws_instance.myec2vm: c => instance.public_dns}
}

# Output Legacy Splat Operator (latest) - Returns the List
output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance_publicdns" {
  description = "Generalized Splat Expression"
  value = aws_instance.myec2vm[*].public_dns
}
```

## Step-07: Execute Terraform Commands
```
# Terraform Initialize
terraform init

# Terraform Validate
terraform validate

# Terraform Plan
terraform plan
Observations: 
1) play with Lists and Maps for instance_type

# Terraform Apply
terraform apply -auto-approve
Observations: 
1) Two EC2 Instances (Count = 2) of a Resource myec2vm will be created
2) Count.index will start from 0 and end with 1 for VM Names
3) Review outputs in detail (for loop with list, maps, maps advanced, splat legacy and splat latest)
Step-08: Terraform Comments
Single Line Comments - # and //
Multi-line Commnets - Start with /* and end with */
We are going to comment the legacy splat operator, which might be decommissioned in future versions
# Output Legacy Splat Operator (latest) - Returns the List
/* output "legacy_splat_instance_publicdns" {
  description = "Legacy Splat Expression"
  value = aws_instance.myec2vm.*.public_dns
}  */
```

## Step-09: Clean-Up
```
# Terraform Destroy
terraform destroy -auto-approve

# Files
rm -rf .terraform*
rm -rf terraform.tfstate*
```


```
meta argument : count
list & maps
    - list (string)
    - map(string)
Loops:
    - for loop with list
    - for loop with map
    - for loop with map advanced
Splat operartor:
    - Legacy splat operator .*.
    - Generalized splat operator (latest)
    - Understand about Terraform Generic Splat Expression [*] when dealing with count Meta-Argument and multiple output values
    
************************************************************************
instance_type = var.instance_type this is for only single value
instance_type = var.instance_type_list[1] this is for list 1 indicates the array mentioned in 
list of instance_type_list in variables
instance_type = var.instance_type_map["dev"] this is for map, from the variables instance_type_map
we have mentioned key value pair here we have given for the value of dev

count = 5
count.index = 0, 1, 2, 3, 4
count = 2
count.index = 0, 1
******************************************************************************************
```
## MY_NOTES
```
variables are mentioned in c2variables.tf file
Under c5_ec2instance.tf
- now going to reference the existing list or maps variables
- this is for list
instance_type = var.instance_type_list[1] # 1 indicates the array mentioned in list of instance_type_list in variables,example: ["t3.small", "t3.micro"] so it will take t3.micro

-  this is for map, from the variables instance_type_map we have mentioned key value pair here we have given for the value of dev
instance_type = var.instance_type_map["dev"]
- so the dev value is t2.small under c2variables.tf file


- COUNT
if we give count = 2
then it will create 2 instances
- count.index = 0, 1
- count.index will start from 0 and end with 1 for VM Names
#######################################################
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

#######################################################

```
## OUTPUTS
```
if the count is 3 then the output will be like this
for_output_list = [
  "ec2-3-84-111-111.compute-1.amazonaws.com",
  "ec2-54-84-111-111.compute-1.amazonaws.com",
  "ec2-54-84-111-111.compute-1.amazonaws.com",
]

output "for_output_list" {
  description = "For Loop with List"
  value = [ for instance in resource:value]
  value = [for instance in aws_instance.myec2vm: instance.public_dns ]
}


# Output - For Loop with Map
output "for loop with map" {
  description = "For Loop with Map"
  value = {for instance in resource:value key => value}} 
  value = {
    for instance in aws_instance.myec2vm: instance.id => instance.public_dns
  } # this instance.id is the key and instance.public_dns is the value
  # is instance.id is anything we need to assign as the key
}

# out put for loop with map advanced
output "for loop with map advanced" {
  description = "For Loop with Map - Advanced"
  value = {for c, instance in resource:value key => value}} 
  value = {
    for c, instance in aws_instance.myec2vm: c => instance.public_dns
  } # this c is the key and instance.public_dns is the value
  # is c is count number 
  # if we have 3 count index then the output will be like this
  for loop with map advanced = {
  "0" = "ec2-3-84-111-111.compute-1.amazonaws.com",
  "1" = "ec2-54-84-111-111.compute-1.amazonaws.com",
  "2" = "ec2-54-84-111-111.compute-1.amazonaws.com",
  }
}

output "for_output_legacy" {
  description = "for loop with map legacy splat operator"
  # value = aws_instance.myec2vm.public_dns this is  ok for count 1 
  value = aws_instance.myec2vm.*.public_dns # for count more than 1 or 2
  
}


```