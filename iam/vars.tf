#Instance profile vars
variable "aws_iam_instance_profile" {
    type = map(any)
        default  = {
            name = ""
        }
}

#Role for access the image builder access the SSM vars
variable "AMI_builder_role" {
    type = object({
        name = string
        managed_policy_arns = list(any)
        assume_role_policy = string
    })
}