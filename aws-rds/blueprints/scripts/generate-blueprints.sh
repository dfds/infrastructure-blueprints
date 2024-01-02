# This will load the scaffolding scripts from aws-modules-rds and generate the blueprints
git clone --branch feature/scaffolding_tools https://github.com/dfds/aws-modules-rds.git

cd aws-modules-rds/tools/scaffolding

ls -a

./generate_blueprints.sh

cp -a auto-generated/. ../../easycreate

# cd ../../..
#rm -rf aws-modules-rds
