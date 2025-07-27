resource "oci_core_volume_backup_policy" "boot_volume_snapshot_policy" {
    compartment_id      = oci_identity_compartment.free_compartment.id
    display_name = "snapshot"

  schedules {
    backup_type       = "INCREMENTAL"
    period            = "ONE_DAY"
    day_of_month      = 10
    hour_of_day       = 01
    offset_seconds    = 00
    offset_type       = "STRUCTURED"
    retention_seconds = 604800
    time_zone         = "REGIONAL_DATA_CENTER_TIME"
  }
  schedules {
    backup_type       = "FULL"
    period            = "ONE_WEEK"
    day_of_month      = 10
    day_of_week       = "TUESDAY"
    hour_of_day       = 1
    offset_seconds    = 00
    offset_type       = "STRUCTURED"
    retention_seconds = 604800
    time_zone         = "REGIONAL_DATA_CENTER_TIME"
  }
}
