provider "aws" {
  region = "us-east-1"
  profile = "default"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}