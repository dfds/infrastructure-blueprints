# This will load the scaffolding scripts from aws-modules-rds and generate the blueprints
# git clone --branch feature/scaffolding_tools https://github.com/dfds/aws-modules-rds.git # TODO: Checkout repo or download zip of the latest release
echo "list files in /"
ls -a

echo "list files in /aws-rds/"

ls -a aws-rds

echo "list files in /aws-rds/blueprints/"
ls /aws-rds/blueprints/scripts/aws-modules-rds/tools/scaffolding

echo "Running generate_blueprints.sh"
./aws-rds/blueprints/scripts/aws-modules-rds/tools/scaffolding/generate_blueprints.sh
echo "Finished running generate_blueprints.sh"
ls -a
cp -a /aws-rds/blueprints/scripts/aws-modules-rds/tools/scaffolding/auto-generated/. /aws-rds/blueprints/easycreate

ls /aws-rds/blueprints/easycreate
# cd ../../..
#rm -rf aws-modules-rds
