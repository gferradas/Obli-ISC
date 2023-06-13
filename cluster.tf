resource "aws_eks_cluster" "cluster" {
  name = var.cluster-name
  role_arn = var.arn-role


  vpc_config {
    subnet_ids = [aws.subnet.subnet.id,aws.subnet.subnet2.id]
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name = aws_eks_cluster.cluster.name
  node_role_arn = var.arn-role
  instance_types = var.worker-type

  subnet_ids = [aws.subnet.subnet.id,aws.subnet.subnet2.id]

  scaling_config {
    desired_size = 3
    max_size = 6
    min_size = 2
  }
}