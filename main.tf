resource "tls_private_key" "instance_ssh_key" {
  count     = var.instance_public_key_path != "" ? 1 : 0
  algorithm = "ED25519"
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance

resource "oci_core_instance" "instance1" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.free_compartment.id
  shape               = var.instance_shape
  display_name        = var.instance_hostname

  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_ocpus
  }

  source_details {
    source_id               = data.oci_core_images.instance_images.images[0].id
    source_type             = "image"
    boot_volume_size_in_gbs = var.instance_boot_volume_size
  }

  #preserve_boot_volume = true

  instance_options {
        are_legacy_imds_endpoints_disabled = true
    }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.free_subnet.id
    nsg_ids          = [oci_core_network_security_group.web_nsg.id]
    display_name     = var.instance_hostname
    hostname_label      = var.instance_hostname
  }

  metadata = {
    ssh_authorized_keys = (var.instance_public_key_path != "") ? file("${var.instance_public_key_path}") : tls_private_key.instance_ssh_key[0].public_key_openssh
    user_data           = base64encode(<<EOF
#cloud-config
users:
  - name: m
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    groups: sudo, wheel
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZD... 
      - ssh-ed25519 AAAAC3NzaC1lZD...
runcmd:
  - echo 'm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/m
EOF
  )
  }

  timeouts {
    create = "60m"
  }

  lifecycle {
    ignore_changes = [
      source_details,
    ]
  }
}

#recuperation du id du volume de l instance1
data "oci_core_boot_volume" "instance1_boot_volume" {
  boot_volume_id = oci_core_instance.instance1.boot_volume_id
}

#association du volume a la policy de snapshot
resource "oci_core_volume_backup_policy_assignment" "boot_volume_policy_assignment1" {
  asset_id  = data.oci_core_boot_volume.instance1_boot_volume.id
  policy_id = oci_core_volume_backup_policy.boot_volume_snapshot_policy.id
}

resource "oci_core_instance" "instance2" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.free_compartment.id
  shape               = var.instance_shape
  display_name        = var.instance2_hostname

  shape_config {
    memory_in_gbs = var.instance_memory
    ocpus         = var.instance_ocpus
  }

  source_details {
    source_id               = data.oci_core_images.instance_images2.images[0].id
    source_type             = "image"
    boot_volume_size_in_gbs = var.instance_boot_volume_size
  }

  instance_options {
        are_legacy_imds_endpoints_disabled = true
    }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.free_subnet.id
    nsg_ids          = [oci_core_network_security_group.web_nsg.id]
    display_name     = var.instance2_hostname
    hostname_label   = var.instance2_hostname
  }

  metadata = {
    ssh_authorized_keys = (var.instance_public_key_path != "") ? file("${var.instance_public_key_path}") : tls_private_key.instance_ssh_key[0].public_key_openssh
    user_data           = base64encode(<<EOF
#cloud-config
users:
  - name: m
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    groups: sudo, wheel
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1...
      - ssh-ed25519 AAAAC3NzaC1lZDI1...
runcmd:
  - echo 'm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/m
EOF
  )
  }

  timeouts {
    create = "60m"
  }

  lifecycle {
    ignore_changes = [
      source_details,
    ]
  }
}

#recuperation du id du volume de l instance2
data "oci_core_boot_volume" "instance2_boot_volume" {
  boot_volume_id = oci_core_instance.instance2.boot_volume_id
}

#association du volume a la policy de snapshot
resource "oci_core_volume_backup_policy_assignment" "boot_volume_policy_assignment2" {
  asset_id  = data.oci_core_boot_volume.instance2_boot_volume.id
  policy_id = oci_core_volume_backup_policy.boot_volume_snapshot_policy.id
}
