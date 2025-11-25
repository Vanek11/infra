terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.109"
    }
  }

  required_version = ">= 1.7.0"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

resource "yandex_vpc_network" "app-network" {
  name = "reddit-app-network"
}

resource "yandex_vpc_subnet" "app-subnet" {
  name           = "reddit-app-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.app-network.id
  v4_cidr_blocks = [var.subnet_cidr]
}


resource "yandex_vpc_security_group" "app-sg" {
  name       = "reddit-app-sg"
  network_id = yandex_vpc_network.app-network.id

  # SSH
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Приложение (по умолчанию reddit слушает 9292)
  ingress {
    protocol       = "TCP"
    port           = 9292
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем всё наружу
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "app" {
  name        = var.instance_name
  platform_id = var.instance_platform_id

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image_id
      size     = var.disk_size_gb
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.app-subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.app-sg.id]
  }

  metadata = {
    # записываем ключ в метаданные для пользователя ubuntu
    "ssh-keys" = "ubuntu:${file(var.public_key_path)}"
  }
}