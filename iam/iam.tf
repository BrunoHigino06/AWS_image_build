#Role for the instance access the SSM to make de instalation os dependences
resource "aws_iam_role" "AMI_builder_role" {
  name = var.AMI_builder_role.name
  managed_policy_arns = var.AMI_builder_role.managed_policy_arns
  assume_role_policy = var.AMI_builder_role.assume_role_policy
}

#Instance profile
resource "aws_iam_instance_profile" "amazonlinux2_ssm_profile" {
  name = var.aws_iam_instance_profile.name
  role = aws_iam_role.AMI_builder_role.name
}