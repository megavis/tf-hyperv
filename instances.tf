variable "master_nodes" {
  default = {
    master_1 = "uahqsrv-elkm01",
    master_2 = "uahqsrv-elkm02",
  }
}

resource "hyperv_vhd" "main_vhd" {
  provider = hyperv.main_stage

  for_each = var.master_nodes

  path = "D:\\Hyper-V\\test\\${each.value}.vhdx"
  source_vm = "Debian"
}

resource "hyperv_network_switch" "vm_switch" {
  provider = hyperv.main_stage

  name = "vm_switch"
}

resource "hyperv_machine_instance" "default" {
  provider = hyperv.main_stage

  for_each = var.master_nodes

  name = each.value

  network_adaptors {
    name = "wan"
    switch_name = hyperv_network_switch.vm_switch.name
  }

  hard_disk_drives {
    path = "D:/Hyper-V/test/${each.value}.vhdx"
    controller_number = 0
    controller_location = 0
  }
}