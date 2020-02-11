export AWS_DEFAULT_PROFILE=edvarga
export AWS_PROFILE=edvarga
aws sts get-caller-identity
aws ec2 describe-instances

export TF_VAR_region=$(
  awk -F'= ' '/region/{print $2}' <(
    grep -A2 "\[.*$AWS_PROFILE\]" ~/.aws/config)
)

# initialize modules and see changes
cd /terraform/terraform-projects-OK-no-FT
../terraform init
../terraform plan -var-file="db.tfvars"

# create infrastructure
../terraform destroy -var-file="db.tfvars"
