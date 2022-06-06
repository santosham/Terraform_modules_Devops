resource "aws_iam_role" "ec2_role"{
    name = "{var.rolename}"
    assume_role_policy =>>EOF
    {
"version": "2012-10-17" ,
"statement" :[
    "Action": "sts:AssumeRole,
    "Principal": {
    "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
            "Sid": ""
}
   ]

    }
    EOF
    tags=
    {
        Env= "{var.environment}"
    }
}