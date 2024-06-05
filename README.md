This is cavecloud
I run it on a dedicated machine (ryzen 3700x (8 cores, 16 threads) with 16G of ram and jbod

The idea behind it to have a quick way of creating disposable kubernetes clusters with
full access to nodes to control and debug any situation imaginable


Building your own debian 12 image:
packer build debian12.pkg.hcl

Creating vms for cluster:
terraform init && terraform plan -out cluster && terraform apply cluster 

Installing kubernetes on the vms:
ansible-playbook -i hosts kubernetes.yml
