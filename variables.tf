variable "user" {
  description = "The user OCID. This can be found in user settings in the Oracle Cloud Infrastructure console. Required if auth is set to 'ApiKey', ignored otherwise."
  type        = string
  default = "ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "fingerprint" {
  description = "The fingerprint for the user's RSA key. This can be found in user settings in the Oracle Cloud Infrastructure console. Required if auth is set to 'ApiKey', ignored otherwise."
  type        = string
  default = "6d:9a:XXXXXXXXXXXXXXXXXXXXXXXXXX:26"
}

variable "tenancy" {
  description = "The tenancy OCID for a user. The tenancy OCID can be found at the bottom of user settings in the Oracle Cloud Infrastructure console. Required if auth is set to 'ApiKey', ignored otherwise."
  type        = string
  default = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "region" {
  description = "The region for API connections (e.g. us-ashburn-1)."
  type        = string
  default = "ca-montreal-1"
}

variable "key_file" {
  description = "The path to the user's PEM formatted private key. A private_key or a private_key_path must be provided if auth is set to 'ApiKey', ignored otherwise."
  type        = string
  default = "./.oci/xxx.pem"
}

variable "image_operating_system" {
  description = "The image's operating system."
  type        = string
  default     = "Canonical Ubuntu"
}

variable "image_operating_system_version" {
  description = "The image's operating system version."
  type        = string
  default     = "22.04"
}

variable "image_operating_system_version2" {
  description = "The image's operating system version."
  type        = string
  default     = "22.04"
}

variable "instance_hostname" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
  default     = "instance1"
}

variable "instance2_hostname" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information."
  type        = string
  default     = "Instance2"
}

variable "instance_shape" {
  description = "The shape of an instance. The shape determines the number of CPUs, amount of memory, and other resources allocated to the instance."
  type        = string
  default     = "VM.Standard.A1.Flex"
}

variable "instance_ocpus" {
  description = "The total number of OCPUs available to the instance."
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "The total amount of memory available to the instance, in gigabytes."
  type        = number
  default     = 12
}

variable "instance_boot_volume_size" {
  description = "The size of the boot volume in GBs. Minimum value is 50 GB and maximum value is 32,768 GB (32 TB)."
  type        = number
  default     = 100
}

variable "instance_public_key_path" {
  description = "Public SSH key to be included in the ~/.ssh/authorized_keys file for the default user on the instance."
  type        = string
  default     = "./.ssh/id_ed25519.pub"
}
