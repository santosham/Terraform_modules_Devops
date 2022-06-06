module  "dev_compute_1"{
    source                     = "../module/compute"
environment                    = module.dev_vpc_1.environment
amis                           = {

    us_east-1                  = "ami-ami-09d56f8956ab235b3"  # ubuntu 20.04 LTS
    us_east-2                  = "ami-ami-09d56f8956ab235b4"  ubuntu 20.04 LTS
}

aws_region                     = var.aws_region
instance_type                  = "t2.nano"
key_name                       = "Laptopkey"
iam_instance_profile           = module.dev_iam_1.instprofile
public_subnets                 =  module.dev_vpc_1.public_subnets_id
private_subnets                =  module.dev_vpc_1.private_subnets_id
sg_id                          =  module.dev_sg_1.sg_id
vpc_name                       =  module.dev_vpc_1.vpc_name
elb_listener                   = module.dev_elb_1.elb_listener
elb_listener_public            = module.dev_elb_1.public.elb_listener
_}

module "dev_elb_1" {
source =  "../modules/elb"
environment                    =  module.dev_vpc_1.environment
nlbname                        =  "dev_nlb"
subnets                        =  module.dev_vpc_1.public_subnets_id
environment                    =  module.dev_vpc_1.public_subnets_id
tgname                         =  "dev_nlb-tg"    
vpc_id                         =  module.dev_vpc_1.vpc_id
private_servers                =  module.dev_compute_1.private_servers
}

module "dev_elb_public" {
source =  "../modules/elb"
environment                    =  module.dev_vpc_1.environment
nlbname                        =  "dev-nlb-public"
subnets                        =  module.dev_vpc_1.public_subnets_id
environment                    =  module.dev_vpc_1.public_subnets_id
tgname                         =  "dev_nlb-tg"    
vpc_id                         =  module.dev_vpc_1.vpc_id
private_servers                =  module.dev_compute_1.public_servers
}


module "dev_iam_1" {
source                         =  "../modules/iam"
environment                    = module.dev_vpc_1.environment
role_name                      = "devopsb24testrole"
instanceprofilename            = "devopsb24instprofile"
}