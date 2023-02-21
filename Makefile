.ONESHELL:
.PHONY: all clean terraform-apply terraform-plan inventory ping hello-world
all: terraform-apply hello-world
clean:
	cd ./terraform
	env $$(cat ../envs/.terraform.env | xargs) terraform destroy
terraform-apply:
	cd ./terraform
	env $$(cat ../envs/.terraform.env | xargs) terraform apply	
terraform-plan:
	cd ./terraform
	env $$(cat ../envs/.terraform.env | xargs) terraform plan
inventory:
	cd ./ansible
	env $$(cat ../envs/.jinja.env | xargs) python3.11 jinja_to_inventory.py
	env $$(cat ../envs/.ansible.env | xargs) ansible-inventory --graph
ping:
	cd ./ansible
	gcloud compute config-ssh --remove
	gcloud compute config-ssh
	env $$(cat ../envs/.jinja.env | xargs) python3.11 jinja_to_inventory.py
	env $$(cat ../envs/.ansible.env | xargs) ansible mc_server_type_java -m ping
hello-world:
	cd ./ansible
	gcloud compute config-ssh --remove
	gcloud compute config-ssh
	env $$(cat ../envs/.jinja.env | xargs) python3.11 jinja_to_inventory.py
	env $$(cat ../envs/.ansible.env | xargs) ansible mc_server_type_java -m shell -a 'echo "Hello World"'