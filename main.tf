provider "aws" {
  region = var.aws_region


  default_tags {
    tags = {
      Project = "epam-tf-lab"
      ID      = "cmtr-6pajwelx"
    }
  }
}
