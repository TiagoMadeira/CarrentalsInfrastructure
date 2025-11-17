data "aws_iam_policy_document" "secrets_carrental" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test      = "StringEquals"
      variable  = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values    = ["system:serviceaccount:default:carrental-sa"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    } 
  }
}

resource "aws_iam_role" "secrets_carrental" {
 name               = "${aws_eks_cluster.eks.name}-secrets-carrental"
 assume_role_policy = data.aws_iam_policy_document.secrets_carrental.json
}

resource "aws_iam_policy" "secrets_carrental" {
  name = "${aws_eks_cluster.eks.name}-secrets-carrental"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = ["arn:aws:secretsmanager:eu-west-3:265766434062:secret:staging/carrental-secret-3MAyfG",
                    "arn:aws:secretsmanager:eu-west-3:265766434062:secret:staging/carrental-db-secret-WcjRhu"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_carrental" {
  policy_arn = aws_iam_policy.secrets_carrental.arn
  role       = aws_iam_role.secrets_carrental.name
}

output "carrental_secrets_role_arn" {
  value = aws_iam_role.secrets_carrental.arn
}


resource "helm_release" "secrets_csi_driver" {
    name = "secrets-store-csi-driver"

    repository      = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    chart           = "secrets-store-csi-driver"
    namespace       = "kube-system"
    version         = "1.4.3"

    # Set for ENV variables
    set = [{
      name  = "syncSecret.enabled"
      value = true
    }]

    depends_on = [aws_eks_addon.ebs_csi_driver]

}

#cloud secrets provider

resource "helm_release" "secrets_csi_driver_aws_provider" {
    name = "secrets-store-cri-driver-provider-aws"

    repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    chart       = "secrets-store-csi-driver-provider-aws"
    namespace   = "kube-system"
    version     = "0.3.8"

    depends_on = [helm_release.secrets_csi_driver]
}

