.PHONY: all clean terraform-apply terraform-plan inventory ping hello-world
all: terraform-apply hello-world
clean:
	env $$(cat .terraform.env | xargs) terraform destroy
terraform-apply:
	env $$(cat .terraform.env | xargs) terraform apply	
terraform-plan:
	env $$(cat .terraform.env | xargs) terraform plan
inventory:
	env $$(cat .jinja.env | xargs) python jinja_to_inventory.py
	env $$(cat .ansible.env | xargs) ansible-inventory --graph
ping:
	gcloud compute config-ssh --remove
	gcloud compute config-ssh
	env $$(cat .jinja.env | xargs) python jinja_to_inventory.py
	env $$(cat .ansible.env | xargs) ansible mc_server_type_java -m ping
hello-world:
	gcloud compute config-ssh --remove
	gcloud compute config-ssh
	env $$(cat .jinja.env | xargs) python jinja_to_inventory.py
	env $$(cat .ansible.env | xargs) ansible mc_server_type_java -m shell -a 'echo "Hello World"'