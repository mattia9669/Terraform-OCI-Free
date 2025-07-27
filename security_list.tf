resource "oci_core_security_list" "free_security_list" {
  compartment_id = oci_identity_compartment.free_compartment.id
  vcn_id         = oci_core_vcn.free_vcn.id
  display_name   = "SecurityList1"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  egress_security_rules {
    protocol  = 1
    destination    = "0.0.0.0/0"

    icmp_options {
      type = 3
      code = 4
    }
  }
}
