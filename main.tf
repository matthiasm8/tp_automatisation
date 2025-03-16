terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
  required_version = ">= 0.14"
}

provider "proxmox" {
  pm_api_url      = "https://167.88.61.235:8006/api2/json"
  pm_tls_insecure = true
  pm_user         = "matthiasm@pve"
  pm_password     = "cm7HwWmf_g1qGadK"
}

resource "proxmox_vm_qemu" "vm" {
  target_node   = "scl-sm2028tp-htr-1-4"
  name   = "vm-matthiasm"
  boot   = "order=scsi0;ide2"
  cores  = 2
  memory = 2048

  network {
    id     = "4"
    model  = "virtio"
    bridge = "vmbr0"
  }

  disk {
    storage = "local"
    size    = "20G"
    slot    = "scsi0"
  }

  disk {
    storage = "local"
    type    = "cdrom"
    iso     = "local:iso/debian-12.9.0-amd64-DVD-1.iso"
    slot    = "ide2"
  }

}