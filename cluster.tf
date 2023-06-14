resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = "arn:aws:iam::268653463774:role/LabRole" 


  vpc_config {
    subnet_ids = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name = aws_eks_cluster.cluster.name
  node_role_arn = "arn:aws:iam::268653463774:role/LabRole"
  instance_types = [ var.worker-type ]

  subnet_ids = [aws_subnet.subnet-1.id,aws_subnet.subnet-2.id]

  scaling_config {
    desired_size = 3
    max_size = 6
    min_size = 2
  }

  depends_on = [ aws_eks_cluster.cluster ]
} 