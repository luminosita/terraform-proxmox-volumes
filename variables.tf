variable "proxmox_api" {
  type = object({
    endpoint     = string
    insecure     = bool
    cluster_name = string
  })
}

variable "volumes" {
  type = map(
    object({
      node         = string
      size         = string
      datastore_id = string
      vmid         = optional(number, 9999)
      format       = optional(string, "raw")
      claim_ref = list(object({
        name      = string
        namespace = optional(string)
      }))
    })
  )
}

variable "cluster_name" {
  type = string
}
