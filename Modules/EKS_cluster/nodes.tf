resource "aws_iam_role" "nodes" {
    name = "${var.environment}-${var.eks_name}-eks-nodes"
    assume_role_policy = <<POLICY
    {
        "Version": "2012-10-17",		 	 	 
        "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
        ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role =aws_iam_role.nodes.name
}

#manage secondary ips for the pods
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role =aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role =aws_iam_role.nodes.name
}

resource "aws_eks_node_group" "general" {
    cluster_name = aws_eks_cluster.eks.name
    version = var.eks_version
    node_group_name = "general"
    node_role_arn = aws_iam_role.nodes.arn

    subnet_ids = [
        var.subnet_private_zone1_id,
        var.subnet_private_zone2_id,
    ]

    capacity_type = "ON_DEMAND"
    instance_types = [var.eks_instances_type]

    scaling_config {
      desired_size = 2
      max_size = 10
      min_size = 0
    }

    update_config {
      max_unavailable = 1
    }

    labels = {
      roles = "general"
    }

    depends_on = [ aws_iam_role_policy_attachment.amazon_eks_cni_policy,
                   aws_iam_role_policy_attachment.amazon_eks_worker_node_policy  
                 ]
    #Allow external changes without Terraform plan diference
    lifecycle {
        ignore_changes = [ scaling_config[0].desired_size ]
    }
}