#IAM inputs
#Instance profile inputs
aws_iam_instance_profile = {
        name = "amazonLinux2_ssm"
}

#Role for access the image builder access the SSM inputs
AMI_builder_role = {
    name = "AMI_builder_role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

#Amazon Lunix 2 AMI inputs
#Key pair inputs
key_name = "amzo2_key"

#Builder Infrastructure configuration inputs
AmazonLinux2_configuration = {
    Environment                 = "production"
    ami_name                    = "AmazonLinux2_ssm"
    description                 = "AMI with SSM agent instaled"
}

#Builder component inputs
AmazonLinux2_component  = {
    name        = "AmazonLinux2_component"
    platform    = "Linux"
    version     = "1.0.0"
}

#Builder Recipe inputs
AmazonLinux2_recipe = {
    parent_image        = "ami-026b57f3c383c2eec"
    recipe_name         = "AmazonLinux2_recipe"
    version             = "1.0.0"
}
