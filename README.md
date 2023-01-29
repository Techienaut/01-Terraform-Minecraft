# 01-Terraform-Minecraft

# 01-About

This project is an automation to setup a Java Minecraft server, using **Google Cloud**, **Terraform**, and **Ansible**.

Some Capabilities:

1. Automate the Installation/Destruction of Infrastructure of..:
    1. A Debian-Based VM instance in the cloud.
    2. A VPC Network (Virtual Private Cloud).
    3. Allocating a Static IP Address for the VM.
    4. A Firewall to only allow SSH, Incoming Minecraft Connections, and ICMP Pings.
    5. An Attached-Storage Disk that holds Minecraft Worlds, and can be snapshot as backups.

# 02-Instructions

1. [Create a Google Cloud Account, Free Tier $150 Credits for 3 Months.](https://cloud.google.com/free)
    1. Create your first project while you’re there. Name is something like “MyName-Terraform-Minecraft”
2. [Download, Install, and Initialize gcloud CLI](https://cloud.google.com/sdk/gcloud#download_and_install_the)
3. [Create a Service Account Key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) for Terraform to interact with GCP.