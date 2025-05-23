resource "kubernetes_persistent_volume" "pv" {
  metadata {
    name = var.volume.name
  }
  spec {
    capacity = {
      storage = var.volume.capacity
    }
    access_modes       = var.volume.access_modes
    storage_class_name = var.volume.storage_class_name
    mount_options      = var.volume.mount_options
    volume_mode        = var.volume.volume_mode
    # dynamic "claim_ref" {
    #   for_each = var.volume.claim_ref.name != null ? [1] : []
    #   content {
    #     name      = var.volume.claim_ref.name
    #     namespace = var.volume.claim_ref.namespace
    #   }  
    # }
    persistent_volume_source {
      csi {
        driver        = var.volume.driver
        fs_type       = var.volume.fs_type
        volume_handle = var.volume.volume_handle
        volume_attributes = {
          cache   = var.volume.cache
          ssd     = var.volume.ssd == true ? "true" : "false"
          storage = var.volume.datastore_id
        }
      }
    }
  }
}
