resource "aws_instance" "private-servers" {
    count     = length(var.environment == "production" ?  3 : 1)
    ami       = lookup(var.amis, var.aws_region)
    instance_type = var.instance_type
    key_name    = var.key_name
    iam_instance_profile           =  var.iam_instance_profile
    subnet_id   =  element(var.private_subnets, count.index)
    vpc_security_group_ids = [var.sg_id]
    associate_private_ip_address= true
    tags ={
    Name             = "${var.vpc_name}-private-server-${count.index +1 }"
    environment      = "${var.environment}"
    }
    
    user_data= <<-EOF
    #!/bin/bash
    sudo apt install nginx -y
    sudo apt install git -y
    sudo git clone -b DevOpsB24 https://github.com/mavrick202/webhooktesting.git
    sudo rm -rf /var/www/html/index.nginx-debian.html
    sudo cp webhooktesting/index.html /var/www/html/index.nginx-debian.html
    sudo cp webhooktesting/style.css /var/www/html/style.css
    sudo cp webhooktesting/storekeeper.js /var/www/html/storekeeper.js
    sed -i '29i <div id="container"><h1>${var.vpc_name}-private-server-${count.index +1}</h1></div' /var/www/html/index.nginx-debian.html
    echo "<div><h1>${var.vpc_name}-private-server-${count.index +1}</h1></div>" >> /var/www/html/index.nginx-debian.html
    EOF
    depends_on [var.elb_listener] 

    }