resource "yandex_vpc_network" "net" {
  name = "hexlet-ruslan-vpc"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "hexlet-ruslan-vpc"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.192.0/24"]
}


resource "yandex_compute_instance" "web" {
  count = 2

  name = "yc-web-server-${count.index}"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8h9co237vlot4fli13"
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.vm_sg.id]
  }

  metadata = {
    ssh-keys = "ruslan:${var.user_ssh_key}"
  }

  connection {
    type        = "ssh"
    user        = "ruslan"
    private_key = var.user_private_ssh_key
    host        = self.network_interface.0.nat_ip_address
  }


  provisioner "remote-exec" {
    inline = [
      <<EOT
sudo docker run -d -p 0.0.0.0:80:3000 \
  -e DB_TYPE=postgres \
  -e DB_NAME=${var.db_name} \
  -e DB_HOST=${yandex_mdb_postgresql_cluster.dbcluster.host.0.fqdn} \
  -e DB_PORT=6432 \
  -e DB_USER=${var.db_user} \
  -e DB_PASS=${var.db_password} \
  ghcr.io/requarks/wiki:2.5
EOT
    ]

  }
}

resource "yandex_vpc_security_group" "vm_sg" {
  name        = "vm-security-group"
  description = "Security group for VM in Yandex Cloud"

  network_id = yandex_vpc_network.net.id

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 22
    to_port        = 22
  }

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 80
    to_port        = 80
  }
}


variable "yc_iam_token" {}

