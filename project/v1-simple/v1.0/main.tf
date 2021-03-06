resource "aws_eks_cluster" "she-eks" {
  name            = var.cluster_name
  role_arn        = aws_iam_role.she-eks-role.arn
  version         = "1.22"
  

  vpc_config {
    subnet_ids = [aws_subnet.dev-subpub01.id, aws_subnet.dev-subpvt01.id]
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.she-AmazonEKSClusterPolicy,
    aws_cloudwatch_log_group.she-eks-cwg
  ]
  enabled_cluster_log_types = ["api", "audit"]
  
}
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.she-eks.endpoint
}

resource "aws_iam_role" "she-eks-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "she-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.she-eks-role.name
}

# Creating CloudWatch Log Group for logging the EKS cluster #

resource "aws_cloudwatch_log_group" "she-eks-cwg" {
  # The log group name format is /aws/eks/<cluster-name>/cluster

  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 1
}

# Creating NodeGroup for worker nodes #

  resource "aws_eks_node_group" "she-dev-group" {
  cluster_name    = aws_eks_cluster.she-eks.name
  node_group_name = "she-dev-group"
  node_role_arn   = aws_iam_role.she-ng-role.arn
  subnet_ids      = aws_subnet.dev-subpvt01[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.she-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.she-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.she-AmazonEC2ContainerRegistryReadOnly,
  ]

//  timeouts {
//     create = "15m"
//     update = "15m"
//   }
}

# Creating IAM Roles and policies for NodeGroup #

resource "aws_iam_role" "she-ng-role" {
  name = "she-eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "she-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.she-ng-role.name
}

resource "aws_iam_role_policy_attachment" "she-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.she-ng-role.name
}

resource "aws_iam_role_policy_attachment" "she-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.she-ng-role.name
}
