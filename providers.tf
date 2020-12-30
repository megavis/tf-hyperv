terraform {
  required_providers {
    hyperv = {
      source = "taliesins/hyperv"
    }
  }
}

variable "admin_password" {
  default = ""
}

provider "hyperv" {
  alias = "main_stage"
  user = "hyperv"
  host = "127.0.0.1"
  port = "5985"
  https = false
  use_ntlm = true
}

//provider "hyperv" {
//  alias = "bcp_stage"
//}
