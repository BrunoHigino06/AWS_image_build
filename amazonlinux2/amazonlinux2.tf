#key pair resources
resource "tls_private_key" "instance_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.instance_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.instance_key.private_key_pem
  filename        = "${var.key_name}.pem"
  file_permission = "0400"
}

#Builder Infrastructure configuration
resource "aws_imagebuilder_infrastructure_configuration" "AmazonLinux2_configuration" {
    instance_profile_name         = var.AmazonLinux2_configuration.instance_profile_name
    description                   = var.AmazonLinux2_configuration.description
    key_pair                      = aws_key_pair.generated_key.key_name
    name                          = var.AmazonLinux2_configuration.ami_name
    terminate_instance_on_failure = true

    tags = {
        Environment = var.AmazonLinux2_configuration.Environment
    }
}
#Builder component
resource "aws_imagebuilder_component" "AmazonLinux2_component" {
  data     = var.AmazonLinux2_component.data
  name     = var.AmazonLinux2_component.name
  platform = var.AmazonLinux2_component.platform
  version  = var.AmazonLinux2_component.version
}

#Builder Recipe
resource "aws_imagebuilder_image_recipe" "AmazonLinux2_recipe" {
  component {
    component_arn = aws_imagebuilder_component.AmazonLinux2_component.arn

  }
  name              = var.AmazonLinux2_recipe.recipe_name
  parent_image      = var.AmazonLinux2_recipe.parent_image
  version           = var.AmazonLinux2_recipe.version
}

resource "aws_imagebuilder_image" "AmazonLinux2" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.AmazonLinux2_recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.AmazonLinux2_configuration.arn

  depends_on = [
    aws_imagebuilder_infrastructure_configuration.AmazonLinux2_configuration,
    aws_imagebuilder_image_recipe.AmazonLinux2_recipe
  ]
}