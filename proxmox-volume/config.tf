locals {
  filename = "vm-${var.volume.vmid}-${var.cluster_name}-${var.volume.name}"
}

resource "restapi_object" "proxmox-volume" {
  path = "/api2/json/nodes/${var.volume.node}/storage/${var.volume.datastore_id}/content/"

  id_attribute = "data"

  force_new = [var.volume.size]

  data = jsonencode({
    vmid     = var.volume.vmid
    filename = local.filename
    size     = var.volume.size
    format   = var.volume.format
  })

  lifecycle {
    prevent_destroy = false
  }
}

output "node" {
  value = var.volume.node
}

output "datastore_id" {
  value = var.volume.datastore_id
}

output "filename" {
  value = local.filename
}
