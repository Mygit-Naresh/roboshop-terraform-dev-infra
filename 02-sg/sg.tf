
module "mongodb" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  var.sg_name
  sg_description =  var.sg_description
  vpc_id = data.aws_ssm_parameter.vpc_id.value
 }
module "user" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "user"
  sg_description =  "security group created to attach user instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  

}
module "catalogue" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "catalogue"
  sg_description =  "security group created to attach catalogue instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

}
module "redis" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "redis"
  sg_description =  "security group created to attach redis instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

}
module "mysql" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "mysql"
  sg_description =  "security group created to attach mysql instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
 
}
module "rabbitmq" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "rabbitmq"
  sg_description =  "security group created to attach rabbitmq instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}
module "payment" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "payment"
  sg_description =  "security group created to attach payment instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
 
}
module "cart" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "cart"
  sg_description =  "security group created to attach cart instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
 
}
module "shipping" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "shipping"
  sg_description =  "security group created to attach shipping instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}
module "ratings" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "ratings"
  sg_description =  "security group created to attach ratings instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  
}
module "web" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "web"
  sg_description =  "security group created to attach web instances"
  vpc_id = data.aws_ssm_parameter.vpc_id.value

}
module "vpn" {
  source = "../../terraform/terraform-aws-securitygroups-module"
  environment = var.environment
  project = var.project
  sg_name =  "vpn"
  sg_description =  "security group created to attach web instances"
  vpc_id = data.aws_vpc.default.id
  
}


# resource "aws_default_security_group" "default_rule" {
#   vpc_id = data.aws_vpc.default.id

#   ingress {
#     protocol  = "tcp"
#     self      = true
#     from_port = 0
#     to_port   = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags =  {
#     Name = "VPN_SG"
#     }
# }
resource "aws_security_group_rule" "vpn_in_home" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 0
 to_port           = 65535
 protocol          = "tcp"
 security_group_id = module.vpn.sg_id
 cidr_blocks = ["0.0.0.0/0"]
 
}
resource "aws_security_group_rule" "mongodb_in_catalogue" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 27017
 to_port           = 27017
 protocol          = "tcp"
 security_group_id = module.mongodb.sg_id
 source_security_group_id = module.catalogue.sg_id
}
resource "aws_security_group_rule" "mongodb_in_user" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 27017
 to_port           = 27017
 protocol          = "tcp"
 security_group_id = module.mongodb.sg_id
 source_security_group_id = module.user.sg_id
}
resource "aws_security_group_rule" "redis_in_user" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 6379
 to_port           = 6379
 protocol          = "tcp"
 security_group_id = module.redis.sg_id
 source_security_group_id = module.user.sg_id
}
resource "aws_security_group_rule" "redis_in_cart" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 6379
 to_port           = 6379
 protocol          = "tcp"
 security_group_id = module.redis.sg_id
 source_security_group_id = module.cart.sg_id
}
resource "aws_security_group_rule" "mysql_in_shipping" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 3306
 to_port           = 3306
 protocol          = "tcp"
 security_group_id = module.mysql.sg_id
 source_security_group_id = module.shipping.sg_id
 }
resource "aws_security_group_rule" "mysql_in_ratings" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 3306
 to_port           = 3306
 protocol          = "tcp"
 security_group_id = module.mysql.sg_id
 source_security_group_id = module.ratings.sg_id
 }
resource "aws_security_group_rule" "rabbitmq_in_payment" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 5672
 to_port           = 5672
 protocol          = "tcp"
 security_group_id = module.rabbitmq.sg_id
 source_security_group_id = module.payment.sg_id
 }
 ########## Allow ibound rule 22 from VPN source group ###########
resource "aws_security_group_rule" "mongodb_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.mongodb.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "redis_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.redis.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "mysql_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.mysql.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "rabbitmq_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.rabbitmq.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "catalogue_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.catalogue.sg_id
 source_security_group_id = module.vpn.sg_id
 }
resource "aws_security_group_rule" "cart_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.cart.sg_id
 source_security_group_id = module.vpn.sg_id
 }
resource "aws_security_group_rule" "user_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.user.sg_id
 source_security_group_id = module.vpn.sg_id
 }
resource "aws_security_group_rule" "payment_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.payment.sg_id
 source_security_group_id = module.vpn.sg_id
 }
resource "aws_security_group_rule" "shipping_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.shipping.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "ratings_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.ratings.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "web_in_vpn" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from vpn servers"
 from_port         = 22
 to_port           = 22
 protocol          = "tcp"
 security_group_id = module.web.sg_id
 source_security_group_id = module.vpn.sg_id
}
resource "aws_security_group_rule" "web_in_home" {
 type              = "ingress"
 description       = "inbound rule for incoming traffic from catalogue servers"
 from_port         = 80
 to_port           = 80
 protocol          = "tcp"
 security_group_id = module.web.sg_id
 cidr_blocks = ["0.0.0.0/0"]
}








