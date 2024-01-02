# This will load the scaffolding scripts from aws-modules-rds and generate the blueprints
# git clone --branch feature/scaffolding_tools https://github.com/dfds/aws-modules-rds.git # TODO: Checkout repo or download zip of the latest release
echo "Cloned aws-modules-rds"
ls -a
cd aws-rds/aws-modules-rds/tools/scaffolding
echo "Running generate_blueprints.sh"
ls -a

./generate_blueprints.sh
echo "Finished running generate_blueprints.sh"
ls -a
cp -a auto-generated/. ../../easycreate

# cd ../../..
#rm -rf aws-modules-rds
