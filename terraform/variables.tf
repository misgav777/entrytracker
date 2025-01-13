## Environment variables ##
variable "region" {
  description = "region"
  type        = string
  default     = "ap-south-1"
}
variable "project_name" {
  description = "project name"
  type        = string
  default     = "entrytracker"
}
variable "environment" {
  description = "environment"
  type        = string
  default     = "Dev"
}

variable "access_key" {
  description = "The AWS access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "The AWS secret key"
  type        = string
  sensitive   = true
}
