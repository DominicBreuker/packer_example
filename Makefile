

build:
	@echo "Building AMI"
	packer build -var-file secrets/packer_vars.json  ./templates/base.json 
