module "proxmox-volume" {
  for_each = var.volumes
  source   = "./proxmox-volume"

  providers = {
    restapi = restapi
  }

  volume = {
    name         = each.key
    node         = each.value.node
    size         = each.value.size
    datastore_id = each.value.datastore_id
    vmid         = each.value.vmid
    format       = each.value.format
  }

  cluster_name = var.cluster_name
}

module "persistent-volume" {
  for_each = var.volumes
  source   = "./persistent-volume"

  providers = {
    kubernetes = kubernetes
  }

  volume = {
    name          = each.key
    capacity      = each.value.size
    volume_handle = "${var.proxmox_api.cluster_name}/${module.proxmox-volume[each.key].node}/${module.proxmox-volume[each.key].datastore_id}/${module.proxmox-volume[each.key].filename}"
    datastore_id  = each.value.datastore_id
    claim_ref     = each.value.claim_ref
  }
}
