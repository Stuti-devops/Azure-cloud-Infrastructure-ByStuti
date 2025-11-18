variable "child_pip" {
  description = "Map of Public IP configurations"
  type = map(object({
    pipname              = string
    location             = string
    resource_group_name  = string
  }))
}