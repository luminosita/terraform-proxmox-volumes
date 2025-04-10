variable "volume" {
  type = object({
    name         = string
    node         = string
    size         = string
    datastore_id = string
    vmid         = optional(number, 9999)
    format       = optional(string, "raw")
  })
}

variable "cluster_name" {
  type = string
}

