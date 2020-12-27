variable "master_nodes" {
  default = 1
}

variable "data_nodes" {
  default = {
    data_1 = "uahqsrv-elkd01"
  }
}

resource "hyperv_network_switch" "virtual_switch" {
  name = "virtual_switch"
  allow_management_os = true
}

#resource "hyperv_vhd" "master_vhd" {
#  for_each = var.master_nodes
#  name =
#}
resource "hyperv_machine_instance" "master_node" {
  count = var.master_nodes
  name = "uahqsrv-elkm${count.index}"

  network_adaptors {
    name = "wan"
    switch_name = hyperv_network_switch.virtual_switch.name
  }

  hard_disk_drives {
    path = "d:\\Hyper-V\\test\\master-node-${count.index}.vhd"
    controller_number = "0"
    controller_location = "0"
  }
}