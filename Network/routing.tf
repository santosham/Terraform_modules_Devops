resource "aws_route_table" public_routing_table" {
    vpc_id = aws_vpc.default.id
    route{
        cidr_block = "0.0.0.0./0"
        nat_gateway_id= var.natgw_id
    }
    tags={
        Name                      = "${var.vpc_name}-public-RT
    DeployedBy                = local.DeployedBy
    CostCenter                = local.CostCenter
    TeamDL                    = local.TeamDL
    environment               = "${var.environment}"
    }
}

resource "aws_route_table" private_routing_table" {
    vpc_id = aws_vpc.default.id
    route{
        cidr_block = "0.0.0.0./0"
        gateway_id= var.natgw_id
    }
    tags={
        Name                  = "${var.vpc_name}-private-RT
    DeployedBy                = local.DeployedBy
    CostCenter                = local.CostCenter
    TeamDL                    = local.TeamDL
    environment               = "${var.environment}"
    }
}


resource "aws_route_table_association"  "public_sunbnets"{
    count = length(var.public_cidr_block)
    subnets_id = element(aws_subnet.public[-subnets.*.id, count.index)
    route_table_id = aws_route_table.public_routing_table.id
}

resource "aws_route_table_association"  "private_sunbnets"{
    count = length(var.private_cidr_block)
    subnets_id = element(aws_subnet.private[-subnets.*.id, count.index)
    route_table_id = aws_route_table.private_routing_table.id
}

