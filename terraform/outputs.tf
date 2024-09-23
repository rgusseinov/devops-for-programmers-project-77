output "webserver_ips" {
  description = "VM IP addresses"
  value       = yandex_compute_instance.web[*].network_interface[0].nat_ip_address
}
