module "iam" {
    source = ".\\iam\\"
    providers = {
      aws = aws.us
     }
     
    #Instance profile inputs
    aws_iam_instance_profile = {
        name = var.aws_iam_instance_profile.name
    }

    AMI_builder_role = {
        name = var.AMI_builder_role.name
        managed_policy_arns = var.AMI_builder_role.managed_policy_arns
        assume_role_policy = "${file("./iam/AmiBuilder_assume_role.json")}"
    }
}


module "amazonlinux2_ssm" {
    source = ".\\amazonlinux2\\"
    providers = {
        aws = aws.us
    }
    #Key pair inputs
    key_name = var.key_name

    #Builder Infrastructure configuration inputs
    AmazonLinux2_configuration = {
        instance_profile_name       = module.iam.amazonlinux2_ssm_profile_name
        Environment                 = var.AmazonLinux2_configuration.Environment
        ami_name                    = var.AmazonLinux2_configuration.ami_name
        description                 = var.AmazonLinux2_configuration.description
    }

    #Builder component inputs
    AmazonLinux2_component  = {
        data        = "${file("./amazonlinux2/AmazonLinux2_ssm.yaml")}"
        name        = var.AmazonLinux2_component.name
        platform    = var.AmazonLinux2_component.platform
        version     = var.AmazonLinux2_component.version
    }

    #Builder Recipe inputs
    AmazonLinux2_recipe = {
        recipe_name         = var.AmazonLinux2_recipe.recipe_name
        parent_image        = var.AmazonLinux2_recipe.parent_image
        version             = var.AmazonLinux2_recipe.version
    }
}