resource "aws_eip" "natgw-eip"{
    vpc= true
}
resource "aws_nat_gatway" "natgw"
allocation_id =aws_eip.natgw-eip.id
subnet_id = var.public_subnets_id
tags={
    Name= "${var.vpc_name}-NAT-GW"
}
}