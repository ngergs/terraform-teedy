# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

################
# ssh
################
resource "digitalocean_ssh_key" "terraform_public" {
    name = "terraform"
    public_key = file(var.terraform_public_ssh_key)
}
resource "digitalocean_ssh_key" "desktop_public" {
    name = "desktop"
    public_key = file(var.desktop_public_ssh_key)
}

################
# project
################
resource "digitalocean_project" "teedy" {
  name        = var.project_name
  description = "A project to experiment with the teedy dms"
  purpose = "Web Application" 
  environment = "Development" 
  resources = [digitalocean_droplet.teedy.urn]
}

################
# droplet
################
data "digitalocean_volume" "teedy" {
  name = "teedy-volume"
}
resource "digitalocean_droplet" "teedy" {
  image  = "docker-18-04"
  name   = "teedy"
  region = var.region
  size   = var.size
  ssh_keys = [digitalocean_ssh_key.desktop_public.id, digitalocean_ssh_key.terraform_public.id]
  volume_ids  = [data.digitalocean_volume.teedy.id]
  provisioner "file" {
    source      = "files/docker-compose.yml"
    destination = "/root/docker-compose.yml"
    connection {
        host = digitalocean_droplet.teedy.ipv4_address
        user = "root"
        private_key = file(var.terraform_private_ssh_key)
        agent = false
    }
  }
  provisioner "remote-exec" {
    script = "files/init.sh"
    connection {
        host = digitalocean_droplet.teedy.ipv4_address
        user = "root"
        private_key = file(var.terraform_private_ssh_key)
        agent = false
    }
  }
}

################
# initial volume
################
#resource "digitalocean_volume" "teedy_volume" {
#  region                  = "fra1"
#  name                    = "teedy-volume"
#  size                    = 10
#  initial_filesystem_type = "ext4"
#}
