variable "cluster_name" {
  default = "she-dev-eks"
  type    = string
}
variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}
variable "kubernetes_version" {
  default     = null
  type        = string
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
}
variable "instance_type" {
  type = list(string)
  default = ["t2.micro"]
}
variable "app_name" {
  type        = string
  description = "Name or ID of the application for which resources are created"
  default = "aws-eks"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "Environment type in which resource will be deployed such as - poc, dev, qty, pre, uat, stg, prd etc."
}
variable "count_log" {
  description = "Number of logs to be created"
  default     = 3
  type        = string
}