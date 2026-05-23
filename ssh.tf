locals {
  ssh_key_pair_name = "cmtr-6pajwelx-keypair"

}

resource "aws_key_pair" "this_key_pair" {
  key_name   = local.ssh_key_pair_name
  public_key = var.ssh_key
}
