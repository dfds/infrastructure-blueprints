# Scaffolding guide

Change directory to where you have <https://github.com/dfds/terraform-aws-rds> checked out.

```bash
cd /dfds/terraform-aws-rds/tools
```

## Build container image and create required directory

Build the container image:

```bash
docker build -t scaffold .
```

Create output folder:

```bash
mkdir auto-generated
```

## Run container

Run newly created image:

Generate blueprint for terraform-aws-rds:

```bash
cd ../..
docker run -e RELEASE=<release-number> -e APP_NAME=database -v $PWD/terraform-aws-rds/:/module \
    -v $PWD/infrastructure-blueprints/tools/scaffolding/templates/aws-rds-postgresql/:/templates \
    -v $PWD/infrastructure-blueprints/tools/auto-generated/:/output scaffold:latest
```

Generate blueprint for terraform-ssm-agent:

```bash
docker run -e RELEASE=<release-number> -e APP_NAME=ssm-agent -v $PWD/terraform-aws-ssm-agent/:/module \
    -v $PWD/infrastructure-blueprints/tools/scaffolding/templates/aws-ssm-agent/:/templates \
    -v $PWD/infrastructure-blueprints/tools/auto-generated/:/output scaffold:latest
```
