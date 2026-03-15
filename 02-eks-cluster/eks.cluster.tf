/*
resource "aws_eks_cluster" "this" {
  name     = "workshop-march-eks-cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {
    subnet_ids = data.aws_subnets.private.ids
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy
  ]
}
*/