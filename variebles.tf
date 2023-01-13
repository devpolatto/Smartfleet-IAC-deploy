variable "common_tags" {
  type = map(any)
  default = {
    ENV           = "development"
    ALIAS_PROJECT = "SmartFleet"
    MANAGED_BY    = "Terraform"
  }
}