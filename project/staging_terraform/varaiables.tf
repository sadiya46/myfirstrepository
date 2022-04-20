variable "eks_cluster_name" {
  default     = ""
  type        = string
  description = "Name of the existing AKS cluster, Keep it empty to enforce new resource creation."
}
variable "environment" {
  default     = "dev"
  type        = string
  description = "Environment type in which resource will be deployed such as - poc, dev, qty, pre, uat, stg, prd etc."
}
variable "app_name" {
  type        = string
  description = "Name or ID of the application for which resources are created"
  default     = "aws-eks"
}
variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}
variable "count_log" {
  description = "Number of logs to be created"
  default     = 3
  type        = string
}