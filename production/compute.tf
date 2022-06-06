module  "prod_compute_1"{
    source = "../module/compute"
environment = module.prod_vpc_1.environment
amis        = {

    us_east-1= "ami-ami-09d56f8956ab235b3"  # ubuntu 20.04 LTS
    us_east-2= "ami-ami-09d56f8956ab235b4"  ubuntu 20.04 LTS
}

aws_region            = var.aws_region
instance_type         = "t2.nano"
key_name              = "Laptopkey"
public_subnets        =  module.prod_vpc_1.public_subnets_id
private_subnets       =  module.prod_vpc_1.private_subnets_id
sg_id                 =  module.prod_sg_1.sg_id
vpc_name              =  module.prod_vpc_1.vpc_name
natgw_id              =   module.prod_natgw_1.natgw_id
}
