
SOURCE_MODULE_PATH="../../"
OUTPUT_FILE="$PWD/temp/doc.json"

# Install terraform-docs
echo "Installing terraform-docs..."
uname=$(uname)
curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.17.0/terraform-docs-v0.17.0-$uname-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
chmod +x terraform-docs
terraform-docs --version

mkdir -p temp

# 1) Generate docs for all modules in a repo
terraform-docs json --show "all" $SOURCE_MODULE_PATH --output-file $OUTPUT_FILE

 # 2) Generate files
mkdir -p auto-generated/terraform
python3 generate_module.py

mkdir -p auto-generated/docker
python3 generate_docker.py

mkdir -p auto-generated/pipeline
# TODO: generate pipeline

rm -rf temp