
resource "proxmox_lxc" "basic" {
  target_node  = "proxmox1"
  hostname     = "pihole-ns1"
  ostemplate   = "local:vztmpl/ubuntu-23.04-standard_23.04-1_amd64.tar.zst"
  password     = "B00TY"
  unprivileged = true
  nameserver = "10.77.2.10"
  gw = "10.77.2.1"

  ssh_public_keys = <<-EOT
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCMkgkhLNF6VrYTGJl9ZrHfFhlzfJggvJDUXdDxrk4g5YM4rvt0hcRGUZzzwC8S02+LPzGwgtl7xax8BsT4OJ2yR3nU86Lk3KvntqqrNTNLycPOjcdEbLSW4Ba7mRTDZSjxtV6oFftfG+iNDFFeASwHFVeIy1yUK1tYQvvawaIqIM3xoiD82vAl0DkNm6r/XF0GhxtFNGYKhPVztM8iyOlDuphLkWbr07bnovEi7p90OvDRmnF+7To1yb4EjuDQb0OMvgSoAhvMQ7koqkrJxWrBRM5HfJ4dKS9A58qH+eOzXUk3/eBYHfc6c1wJEMzir9meru7xYaFfEi24adZQ0wWUlp41JXenWd0VKeiOlz1bZmcgRn53UlXq8M9j37WSP0dwIZ0dnlwr6WShTFm58CL2H5vJTSXzucGRqHqtZKsHr/Jf3UX0kSCxQlPXRE04GbCh9n2aVfM98gidm75ug0wJ0mx5TRjrEuZ9gXZyPbz1SRqRJ3L8CmaTfD+UBre9mHM= tfuser@ansible
  EOT  

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.77.2.200/24"
    tag = 2
  }
}



/*
# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "ns1" {
    
    # VM General Settings
    target_node = "proxmox1"
    vmid = "100"
    name = "ns1"
    desc = "DNS Name Server 1"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "piholetemplate"

    # VM System Settings
    #agent = 1
    
    # VM CPU Settings
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings
    memory = 512

    # VM Network Settings
    network {
        bridge = "vmbr0"
        model  = "virtio"
        tag  = 2
    }

    # VM Disk Settings - Boot Drive
    #disks {
    #    storage = "local-lvm"
    #    type  = "virtio"
    #    size = "75G"
    #}    

    # VM Disk Settings - Data Drive
    #disks {
    #    storage = "abc"
    #    type  = "virtio"
    #    size = "20G"
    #}      

    # VM Cloud-Init Settings
    os_type = "cloud-init"

    # (Optional) IP Address and Gateway
    # ipconfig0 = "ip=0.0.0.0/0,gw=0.0.0.0"
    
    # (Optional) Default User
    # ciuser = "your-username"
    
    # (Optional) Add your SSH KEY
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF
}
*/