module "dev_sg_1"{
    source   = "../module/sg"
    vpc_name  =  module.dev_vpc_1.vpc_name
    vpc_id  =    module.dev_vpc_1.vpc_id
    environment  = module.dev_vpc_1.vpc.environment
    service_ports = ["80", "443", "445", "8080", "22", "3389"]
}
