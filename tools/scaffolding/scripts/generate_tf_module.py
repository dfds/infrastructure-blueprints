"""This scripts generates boiler plates for using Terraform files. Input: Template files, Output: Terraform module."""
import json
from string import Template
import re
import os

import argparse

parser = argparse.ArgumentParser(
                    prog='Terraform Module Generator',
                    description='This scripts generates boiler plates for using Terraform files. Input: Template files, Output: Terraform module.',
                    epilog='.')
parser.add_argument('--source-tf-doc', type=str, required=True, help='The json file generated by terraform-docs tool.')
parser.add_argument('--temp-work-folder', type=str, required=True, help='The temporary folder to store the intermediate files.')
parser.add_argument('--tf-module-template', type=str, required=True, help='The template file for the terraform module.')
parser.add_argument('--tf-output-path', type=str, required=True, help='The output path for the terraform module.')
args = parser.parse_args()

source_doc = args.source_tf_doc
work_folder = args.temp_work_folder
tf_template = args.tf_module_template
output_folder = args.tf_output_path

with open(source_doc, "r", encoding='UTF-8') as f:
    lines = f.readlines()

with open(work_folder, "w", encoding='UTF-8') as f:
    for line in lines:
        if not(line.strip("\n") == "<!-- BEGIN_TF_DOCS -->" or line.strip("\n") == "<!-- END_TF_DOCS -->"):
            f.write(line)
input_list = []
output_list = []
OUTPUT_TEMPLATE = """output "$out_name" {
  description = "$output_description"
  value       = try(module.db_instance.$out_value, null)
}"""

with open(work_folder, "r", encoding='UTF-8') as f:
    data = json.load(f)
    for i in data['inputs']:
        if i['name'].startswith('is_'):
            extracted_feature = re.search('(?<=is_)(.*?)(?=_|$)', i['name'])
            if extracted_feature:
                desc = i['description']
                input_list.append("")
                for line in desc.splitlines():
                    input_list.append('# ' + line)
                feature = extracted_feature.group(0)
                if i['required'] is False:
                    if i['type'] == 'bool':
                        param_val = i['default']
                        input_list.append(i['name'] + ' = ' + str(param_val).lower())
        elif i['required'] is True:
            desc = i['description']
            input_list.append("")
            for line in desc.splitlines():
                input_list.append('# ' + line)
            input_list.append(i['name'] + ' = "example"')
    for y in data['outputs']:
        output_sub = {
            'out_name': y['name'],
            'output_description': y['description'],
            'out_value': y['name'],
        }
        output_list.append(Template(OUTPUT_TEMPLATE).substitute(output_sub))

vars_sub = {
    'release': os.environ['RELEASE'],
    'inputs': '\n'.join(input_list),
    'outputs': '\n'.join(output_list)
}

with open(tf_template, 'r', encoding='UTF-8') as f:
    src = Template(f.read())
    result = src.substitute(vars_sub)

with open(output_folder, "w", encoding='UTF-8') as f:
    f.write(result)
