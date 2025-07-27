provider "http" {}

data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}


resource "oci_core_network_security_group" "web_nsg" {
  compartment_id = oci_identity_compartment.free_compartment.id
  vcn_id         = oci_core_vcn.free_vcn.id
  display_name   = "Web Server NSG"
}

resource "oci_core_network_security_group_security_rule" "web_nsg_http_rule" {
  network_security_group_id = oci_core_network_security_group.web_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
  description = "Allow HTTP traffic"
}

resource "oci_core_network_security_group_security_rule" "web_nsg_https_rule" {
  network_security_group_id = oci_core_network_security_group.web_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "0.0.0.0/0"
  
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
  description = "Allow HTTPS traffic"
}

resource "oci_core_network_security_group_security_rule" "web_nsg_ssh_rule" {
  network_security_group_id = oci_core_network_security_group.web_nsg.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "CIDR_BLOCK"
  source                    = "${chomp(data.http.my_ip.response_body)}/32"
  
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
  description = "Allow SSH traffic"
}
