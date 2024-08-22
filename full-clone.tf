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
