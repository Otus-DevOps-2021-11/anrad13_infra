provider "yandex" {
  #token     = "AQAAAABbeHdsAATuwT4HAf7Qjk4LlwR9GtYRbH4"
  #cloud_id  = "b1g3rqcb7ocnh12k8ubl"
  #folder_id = "b1gv6t1evq0gr4fsevdl"
  #zone      = "ru-central1-a"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

#-------
resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  resources {
    cores  = 2
    memory = 2
  }



  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      #image_id = "fd8eau7fhvjjvaqiec6g"
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    #subnet_id = "e9bgj9g69215aih7t6je"
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    #ssh-keys = "ubuntu:${file("~/.ssh/appuser.pub")}"
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    #private_key = file("~/.ssh/appuser")
    private_key = file(var.provisioner_connection_private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
