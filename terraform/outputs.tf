output "webserver_ips" {
  description = "VM IP addresses"
  value       = yandex_compute_instance.web[*].network_interface[0].nat_ip_address
}

output "db_username" {
  description = "DB username"
  value       = yandex_mdb_postgresql_user.dbuser.name
  sensitive   = true
}

output "db_name" {
  description = "DB name"
  value       = yandex_mdb_postgresql_database.db.name
  sensitive   = true
}

output "db_password" {
  description = "DB password"
  value       = yandex_mdb_postgresql_user.dbuser.password
  sensitive   = true
}

output "db_cluster_id" {
  description = "DB cluster id"
  value       = yandex_mdb_postgresql_cluster.dbcluster.id
  #sensitive   = true
}

output "db_host" {
  description = "DB host 7777777777777777777"
  value       = yandex_mdb_postgresql_cluster.dbcluster.host.0.fqdn
  #sensitive   = true
}
