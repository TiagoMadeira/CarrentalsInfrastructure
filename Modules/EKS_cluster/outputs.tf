output  "aws_iam_openid_connect_provider_arn" {
    value = aws_iam_openid_connect_provider.eks.arn
}

output  "aws_iam_openid_connect_provider_url" {
    value = aws_iam_openid_connect_provider.eks.url
}


output "aws_eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}