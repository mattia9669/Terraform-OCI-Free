# Outputs for compartment

output "compartment-name" {
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the parent."
  value       = oci_identity_compartment.free_compartment.name
}

output "compartment-id" {
  description = "The OCID of the compartment."
  value       = oci_identity_compartment.free_compartment.id
}

# Outputs for compute instance

output "instance-name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
  value       = oci_core_instance.instance1.display_name
}

output "instance-region" {
  description = "The region that contains the availability domain the instance is running in."
  value       = oci_core_instance.instance1.region
}

output "instance-shape" {
  description = "The shape of the instance. The shape determines the number of CPUs and the amount of memory allocated to the instance."
  value       = oci_core_instance.instance1.shape
}

output "instance-state" {
  description = "The current state of the instance."
  value       = oci_core_instance.instance1.state
}

output "instance-public-ip" {
  description = "The public IP address of instance VNIC (if enabled)."
  value       = oci_core_instance.instance1.public_ip
}


output "instance-name2" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
  value       = oci_core_instance.instance2.display_name
}

output "instance2-region" {
  description = "The region that contains the availability domain the instance is running in."
  value       = oci_core_instance.instance2.region
}

output "instance2-shape" {
  description = "The shape of the instance. The shape determines the number of CPUs and the amount of memory allocated to the instance."
  value       = oci_core_instance.instance2.shape
}

output "instance2-state" {
  description = "The current state of the instance."
  value       = oci_core_instance.instance2.state
}

output "instance2-public-ip" {
  description = "The public IP address of instance VNIC (if enabled)."
  value       = oci_core_instance.instance2.public_ip
}
