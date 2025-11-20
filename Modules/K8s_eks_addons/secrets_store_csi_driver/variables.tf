variable "secrets_arn" {
 description = "List of secret ARN resources"
 type        = list(string)
}

variable "eks_name" {
  description = "Name of the eks"
}

variable "aws_iam_openid_connect_provider_arn" {
    description = "ARN of the oicp"
}

variable "aws_iam_openid_connect_provider_url" {
    description = "URL of the oicp"
}
