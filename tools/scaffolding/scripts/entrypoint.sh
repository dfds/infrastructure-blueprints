scripts_path="/scripts"
source_module_path="/module"

if [ ! -d "/output" ]; then
	echo "output folder does not exist"
	exit 1
fi

if [ ! -z "$APP_NAME" ]; then
	app_name="$APP_NAME"
else
	app_name="myapp"
fi

# TERRAFORM DOCS
output_json_file="/tmp/doc.json"

# TERRAFORM
source_json_doc=$output_json_file
generated_tf_module_data="/tmp/tf_module.json"
tf_module_template_folder="/templates/terraform/"
tf_module_template="templates/terraform/main.tf.template"
tf_module_output="/output/terraform/module.tf"
tf_output_folders="/output/terraform"

# TERRAGRUNT
tg_module_template_folder="/templates/terragrunt/"
tg_root_template="/templates/terragrunt/terragrunt-root.hcl.template"
tg_env_template="/templates/terragrunt/env.hcl.template"
tg_local_template="/templates/terragrunt/terragrunt.hcl.template"
tg_output_folders="/output/terragrunt"
tg_output_folders_test=$tg_output_folders/test
tg_output=$tg_output_folders_test/$app_name/terragrunt.hcl

# DOCKER
docker_template_folder="/templates/docker/"
docker_compose_template="/templates/docker/compose.yml.template"
docker_compose_output="/output/docker/compose.yml"
docker_env_template="/templates/docker/.env.template"
docker_env_output="/output/docker/.env"
docker_script_template="/templates/docker/restore.sh.template"
docker_script_output="/output/docker/restore.sh"
docker_output_folders="/output/docker"

# Documentation
documentation_output="/output/variables.md"

if [ -z "$(ls -a $source_module_path)" ]; then
	echo "empty $source_module_path"
	exit 1
fi

# 1) Generate docs for all modules in a repo
terraform-docs json --show "all" $source_module_path --output-file $output_json_file

# 2) Generate TF files if template is provided
if [ -d $tf_module_template_folder ]; then
	mkdir -p $tf_output_folders
	python3 $scripts_path/generate_tf_module.py --source-tf-doc $source_json_doc --temp-work-folder $generated_tf_module_data --tf-module-template $tf_module_template --tf-output-path $tf_module_output
	# 3) Format TF files
	terraform fmt $tf_output_folders
else
	echo "No terraform module template provided"
fi

# 4) Generate Docker files
if [ -d $docker_template_folder ]; then
	mkdir -p $docker_output_folders
	python3 $scripts_path/generate_docker.py --docker-compose-template $docker_compose_template --docker-compose-output $docker_compose_output --env-template $docker_env_template --env-output $docker_env_output --docker-script-template $docker_script_template --docker-script-output $docker_script_output
else
	echo "No Docker template provided"
fi

# 5) Generate documentation
terraform-docs markdown --show "inputs" $source_module_path --output-file $documentation_output

# # 6) Generate terragrunt files
if [ -d $tg_module_template_folder ]; then
	mkdir -p $tg_output_folders_test/$app_name
	python3 $scripts_path/generate_tf_module.py --source-tf-doc $source_json_doc --temp-work-folder $generated_tf_module_data --tf-module-template $tg_local_template --tf-output-path $tg_output
	cp $tg_root_template $tg_output_folders/root.hcl
	cp $tg_env_template $tg_output_folders_test/env.hcl

	terragrunt hclfmt --terragrunt-working-dir $tg_output_folders
else
	echo "No terragrunt module template provided"
fi

# # TODO: generate pipeline
