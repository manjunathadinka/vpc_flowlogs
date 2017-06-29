variable "vpc_flowlog_name" {
  type = "string"
}
variable "vpc_id" {
  type = "string"
}
variable "aws_traffic_type" {
  default = "ALL"
}
variable "aws_region" {
  default = "us-west-1"
}
