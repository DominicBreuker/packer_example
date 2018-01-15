SECRETS_FILE = "./secrets/aws.json"
VARS_FILE = "./variables/base.json"
TEMPLATE_FILE = "./templates/base.json"

build:
	@echo "Building AMI"
	packer build -var-file $(SECRETS_FILE)  -var-file $(VARS_FILE) $(TEMPLATE_FILE)

validate:
	@echo "Validating AMI specification"
	packer validate -var-file $(SECRETS_FILE)  -var-file $(VARS_FILE) $(TEMPLATE_FILE)
