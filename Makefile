all:
	env $$(cat .terraform.env | xargs) terraform apply
clean:
	env $$(cat .terraform.env | xargs) terraform destroy
plan:
	env $$(cat .terraform.env | xargs) terraform plan
