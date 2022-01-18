variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "fd88choqv540vfvockcr"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "fd8krr4ed8qdn2f8imb0"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key .json"
}

variable provisioner_connection_private_key_path {
  description = "Path to private key for provisioner connection"
}
