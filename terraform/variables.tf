variable "yc_token" {
  description = "OAuth токен для Yandex Cloud"
  type        = string
}

variable "yc_cloud_id" {
  description = "ID облака Yandex Cloud"
  type        = string
}

variable "yc_folder_id" {
  description = "ID каталога (folder) Yandex Cloud"
  type        = string
}

variable "yc_zone" {
  description = "Зона доступности, например ru-central1-b"
  type        = string
}

variable "public_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
}

variable "private_key_path" {
  description = "Путь к приватному SSH-ключу (для remote-exec)"
  type        = string
}

variable "instance_name" {
  description = "Имя виртуальной машины"
  type        = string
  default     = "reddit-app"
}

variable "instance_platform_id" {
  description = "Платформа ВМ (тип процессора)"
  type        = string
  default     = "standard-v3"
}

variable "instance_cores" {
  description = "Количество vCPU"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "ОЗУ в ГБ"
  type        = number
  default     = 2
}

variable "disk_image_id" {
  description = "ID образа диска (reddit-base)"
  type        = string
}

variable "disk_size_gb" {
  description = "Размер диска в ГБ"
  type        = number
  default     = 20
}

variable "subnet_cidr" {
  description = "CIDR подсети"
  type        = string
  default     = "10.0.1.0/24"
}
