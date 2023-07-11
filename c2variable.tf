#Input Variables
# ------------------------------AWS Region------------------------------
variable "aws_region" {
  description = "Region in which resource will be created"
  type        = string
  default     = "us-east-1"
}
# ------------------------------EC2 instance type------------------------------
variable "instance_type" {
  type    = string
  default = "t2.micro"
  // if we want to give password input we use sensitive =true 
}
#------------------------------EC2 Key pair ------------------------------
variable "instance_keypair" {
  type    = string
  default = "april"

}
#-------------------------- AWS EC2 Instance type -with list ------------------------------
variable "instance_type_list" {
  type = list(string) # going to have list of strings
  default = [ "t2.micro","t2.small" ] # [] are used for list
}
#-------------------------- AWS EC2 Instance type -with Map ------------------------------
variable "instance_type_map" {
  type = map(string) 
  default = {
    "dev" = "t2.small"
    "qa" = "t2.micro"
    "prod" = "t3.large"
  }
}