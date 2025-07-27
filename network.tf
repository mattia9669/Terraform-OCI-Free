resource "oci_identity_compartment" "free_compartment" {
  compartment_id = var.tenancy
  description    = "Oracle Cloud Free Tier compartment"
  name           = "web"
  enable_delete  = true
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn

resource "oci_core_vcn" "free_vcn" {
  cidr_block     = "10.10.0.0/16"
  compartment_id = oci_identity_compartment.free_compartment.id
  display_name   = "VCN1"
  dns_label      = "VCN1"
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet

resource "oci_core_subnet" "free_subnet" {
  cidr_block        = "10.10.2.0/24"
  display_name      = "Subnet1"
  dns_label         = "subnet1"
  #security_list_ids = [oci_core_security_list.free_security_list.id]
  compartment_id    = oci_identity_compartment.free_compartment.id
  vcn_id            = oci_core_vcn.free_vcn.id
  route_table_id    = oci_core_route_table.free_route_table.id
  dhcp_options_id   = oci_core_vcn.free_vcn.default_dhcp_options_id
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway

resource "oci_core_internet_gateway" "free_internet_gateway" {
  compartment_id = oci_identity_compartment.free_compartment.id
  display_name   = "IG1"
  vcn_id         = oci_core_vcn.free_vcn.id
}

# https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table

resource "oci_core_route_table" "free_route_table" {
  compartment_id = oci_identity_compartment.free_compartment.id
  vcn_id         = oci_core_vcn.free_vcn.id
  display_name   = "RT1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.free_internet_gateway.id
  }
}
