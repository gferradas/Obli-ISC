resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = var.arn_role


  vpc_config {
    subnet_ids = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name = aws_eks_cluster.cluster.name
  node_role_arn = var.arn_role
  instance_types = [ var.worker-type ]
  node_group_name = var.workers-name
  ami_type = var.ami
  remote_access {
    ec2_ssh_key = "vockey"
  }

  subnet_ids = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]

  scaling_config {
    desired_size = 3
    max_size = 6
    min_size = 2
  }

  depends_on = [ aws_eks_cluster.cluster ]
} 