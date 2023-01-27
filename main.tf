terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.47.0"
    }
  }
}
provider "google" {
  project = var.gcp_project_name
  region  = var.gcp_project_region
  zone    = var.gcp_project_zone
}

resource "google_compute_network" "vpc_network" {
  name                    = "mc-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_address" "ip_address" {
  name = "mcserver-java-external-ip-address"
}

resource "google_compute_instance" "vm_instance" {
  name         = "mcserver-java"
  machine_type = var.mcserver_java_machine_type
  tags         = ["mcserver-java-tag"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      type  = "pd-ssd"
      size  = 25
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.ip_address.address
    }
  }
  service_account {
    scopes = ["storage-rw"]
  }
}

resource "google_compute_firewall" "mcserver_java_firewall" {
  name    = "mcserver-java-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "25565"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["mcserver-java-tag"]
}

output "ip_address" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}
