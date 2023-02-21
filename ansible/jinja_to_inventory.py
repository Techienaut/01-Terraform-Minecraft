import os
from jinja2 import Environment, FileSystemLoader

PROJECT = os.getenv('PROJECT')
BASE_FILENAME = "inventory.gcp.yml"

environment = Environment(loader=FileSystemLoader("templates/"))
template = environment.get_template(BASE_FILENAME + ".j2")
output_file = BASE_FILENAME

content = template.render(
    PROJECT=PROJECT
)
with open(output_file, mode="w", encoding="utf-8") as message:
    message.write(content)
