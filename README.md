# Packer example

## Overview

Packer can automate the creation of AMIs on AWS.
After setting up your AWS account for use with Packer (add a user with required permissions, get it's access and secret keys), you can run `make build` to create the machine templates in `templates/base.json`.
Details below:

## Details

### Setup AWS

You need a user with permissions to perform various EC2 actions since Packer creates AMIs by launching, configuring and snapshotting EC2 instances.
Create the following policy (https://www.packer.io/docs/builders/amazon.html#using-an-iam-task-or-instance-role):
```
{
  "Version": "2012-10-17",
  "Statement": [{
      "Effect": "Allow",
      "Action" : [
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CopyImage",
        "ec2:CreateImage",
        "ec2:CreateKeypair",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteKeypair",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:DeregisterImage",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:GetPasswordData",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifySnapshotAttribute",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances"
      ],
      "Resource" : "*"
  }]
}
```
Next, create a user with programmatic access and assign this policy.
Then create a var file `secrets/aws.json` (gitignored) with the following contents:
```
{
    "aws_access_key": "your-access-key",
    "aws_secret_key": "your-secret-key"

}
```

### Define a template

AMIs are defined in a JSON-formatted template file. 
This example defines a `templates/base.json` which is a simple Ubuntu 16.04 machine.
The most important parts of the template are the builders and provisioners.
Builders define what is being built and what specific properties shall be defined.
Here, we use the builder of type `amazon-ebs` to build an EBS-backed AWS AMI.
As a provisioner, we use `file` to just run some shell scripts for setup.

Temaplates can contain variables, which can be defined in seperate files.
We use one file `secrets/aws.json` for secrets (gitignored) and another `variables/base.json` for general variables.

### Build a template

Once defined, run `packer validate <template-file>` to validate.
Use the `-var-file <variables-file>` flag to pass variables.
If this works, try `packer build` with the same arguments to actually build the AMI.

In this example, the two commands are defined in `Makefile` and run:
- `make validate`: `packer validate -var-file $(SECRETS_FILE)  -var-file $(VARS_FILE) $(TEMPLATE_FILE)`
- `make build`: `packer build -var-file $(SECRETS_FILE)  -var-file $(VARS_FILE) $(TEMPLATE_FILE)`
