provider "kubernetes" {
    #load_config_file = false
    host = data.aws_eks_cluster.myapp-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.myapp-cluster.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.myapp-cluster.token
}

data "aws_eks_cluster" "myapp-cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "myapp-cluster" {
    name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.6.0"

  cluster_name = "myapp-eks-cluster"
  cluster_version = "1.17"

  subnet_ids = module.myapp-vpc.private_subnets

  vpc_id = module.myapp-vpc.vpc_id

  self_managed_node_group_defaults = {
      instance_type = "t2.micro"

  tags = {

      environment = "development"
      application = "myapp"
  }
    
  }
}
  

  

