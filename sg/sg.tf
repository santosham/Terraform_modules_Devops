locals{
ports_in =[
    443,
    80,
    22
]
ports_outs= [
    22,
    3389,
    80,
    443,
    8080
]
}
resource "aws_security_group" "allow_all" {
    name= "${var.vpc_name}-allow_all"
    description= "Allow all inbound traffic"
    vpc_id = "aws_vpc.default.id"
    dynamic "ingress"
    {
        for_each = var.service_ports
        content
        {
            from_port = ingress.value
            to_port   =  ingress.value
            protocol= "tcp"
            cidr_blocks =["0.0.0.0/0"]
        }
    }
    dynamic egress
    {
        from_port   = ingress.value
        to_port     =  ingress.value
        protocol    = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
    }
    tags= {
        Name= "${var.vpc_name}-allow_all"
        environment= ${var.environment}
    }
    }
    