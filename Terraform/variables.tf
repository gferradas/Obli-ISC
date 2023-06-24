variable "arn_role" {
}

variable "cluster_name" {
  type = string
}

variable "worker-type" {
  type = string
}

variable "cidr-vpc" {
  type = string
}

variable "cidr-subnet-2" {
  type = string
}

variable "cidr-subnet-1" {
  type = string
}

variable "ssh" {
  type = number
}

variable "ami" {
  type = string
}

variable "workers-name" {
  type = string
}

variable "cidr-global" {
  type = string
}