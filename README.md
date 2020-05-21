# teedy terraform digitalocean setup

This is a simple example terraform project that sets up a digitalocean droplet and volume at digitalocean for the [teedy dms](https://github.com/sismics/docs) and starts the corresponding docker container.

## How to use it?
Adjust the terraform.tfvars:
* Generate a ssh-key pair without a passphrase and adjust the terraform_public_ssh_key and terraform_private_ssh_key accordingly.
* desktop_public_ssh_key is a key for you to log into the droplet.
* do_token has to be your DigitalOcean access token.
* domain is required for the domain entry, if you don't own a domain remove the corresponding part from the main.tf.
Adjust the nginx.conf to remove tls if desired, else adjust the domain name.
* Now just run terraform init followed up by terraform apply / destroy as usual.

## What is created at digitalocean?
* One droplet with 1 cpu and 1gb ram droplet with an attached volume.
* A project called teddy to manage the droplet.
* A domain with a A-level dns entry as well as a CNAME alias.
* One ssh public key for terraform and one for the desktop user (possible to be identical).

