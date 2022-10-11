#Amazon Lunix 2 AMI vars
#Key pair vars
variable "key_name" {}
#Builder Infrastructure configuration vars
variable "AmazonLinux2_configuration" {
    type = map(any)
        default             = {
            instance_profile_name   = ""
            Environment             = ""
            ami_name                = ""
            description             = ""
        }
}

#Builder component
variable "AmazonLinux2_component" {
    type = map(any)
        default         = {
            data        = ""
            name        = ""
            platform    = ""
            version     = ""
        }
}

#Builder Recipe vars
variable "AmazonLinux2_recipe" {
    type = map(any)
        default                 = {
            recipe_name         = ""
            parent_image        = ""
            version             = ""
        }
}