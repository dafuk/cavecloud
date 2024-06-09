This is cavecloud
===
I run it on a dedicated machine (ryzen 3700x (8 cores, 16 threads) with 16G of ram and jbod

The idea behind it to have a quick way of creating disposable kubernetes clusters with
full access to nodes to control and debug any situation imaginable

my setup has non-dhcp range (192.168.0.200-) assigned to the control-plane (master) and nodes,
this way I get sequential ips, easy ssh access from both hw node and my laptop.


## Building your own debian 12 image:
```
packer build debian12.pkg.hcl
```
takes just a little over 9 minutes to build an image

## Creating vms for cluster:
```
terraform init && terraform plan -out cluster && terraform apply cluster 
```
not more than a minute to raise the machines (todo: remove grub timeout for speed)

## Installing kubernetes on the vms:
```
ansible-playbook -i hosts kubernetes.yml
```
takes some time, though depends on your network speed and hardware

## When done, ssh into control-plane node
```
kubectl get nodes ; kubectl get po -A -o wide
```
you have a fully working cluster, now install helm and get wild
