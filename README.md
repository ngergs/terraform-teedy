# teedy terraform digitalocean setup

This is a simple example terraform project that sets up a digitalocean droplet and volume at digitalocean for the [teedy dms](https://github.com/sismics/docs) and starts the corresponding docker container.

## How to use it?
* Adjust the terraform.tfvars as you like. You have to provide your access token from digital ocean via the do_token variable.
* terraform init followed up by terraform apply / destroy as usual.

## What is created at digitalocean?
* One droplet with 1 cpu and 1gb ram droplet with an attached volume.
* A project called teddy to manage the droplet.
* One ssh public key for terraform and one for the desktop user (possible to be identical).

