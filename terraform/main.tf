provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-dl"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

# Generación de la clave SSH desde Terraform (para evitar duplicados)
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file("${path.root}/ddg-dl-temp.pub")
}

module "ecr" {
  source           = "./modules/ecr"
  ecr_name         = "dl-web-app-ecr"
}

# EC2, SG, VPC, Subnet, IGW, Route Table
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  name       = var.vpc_name
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  name   = var.sg_name
  my_ip  = var.my_ip
}

module "subnet" {
  source                    = "./modules/subnet"
  vpc_id                    = module.vpc.vpc_id
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  public_subnet_name        = var.public_subnet_name
  private_subnet_name       = var.private_subnet_name
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = var.gateway_name
}

module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.igw.internet_gateway_id
  public_subnet_id    = module.subnet.public_subnet_id
  name                = var.public_route_table_name
}

module "iam" {
  source = "./modules/iam"
}

module "sns" {
  source               = "./modules/sns"
  sns_topic_name       = var.sns_topic_name
  subscriber_email     = var.subscriber_email
  subscriber_email_lambda = var.subscriber_email_lambda
  sns_lambda_topic_name = var.sns_lambda_topic_name
}

module "lambda" {
  source = "./modules/lambda"
  lambda_exec_role_arn  = module.iam.lambda_exc_role_arn
  lambda_sqs_queue_arn  = module.sqs.sqs_arn
  lambda_sns_topic_arn  = module.sns.sns_lambda_topic_arn
  depends_on            = [module.iam, module.sns, module.sqs]
}

module "ec2" {
  source                = "./modules/ec2"
  ami_id                = var.ami_id
  iam_instance_profile  = module.iam.instance_profile_name
  instance_type         = "t2.micro"
  subnet_id             = module.subnet.public_subnet_id
  security_group_id     = module.sg.security_group_id
  name                  = var.ec2_name
  key_name              = aws_key_pair.key_pair.key_name  # Usando la clave generada en Terraform

  depends_on            = [module.iam]
}

module "cloudwatch" {
  source        = "./modules/cloudwatch"
  instance_id   = module.ec2.instance_id
  sns_topic_arn = module.sns.sns_topic_arn
}

module "sqs" {
  source = "./modules/sqs"
}
