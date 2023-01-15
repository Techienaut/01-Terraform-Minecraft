all:
	env $(cat .terraform.env) terraform apply -auto-approve