data_dir = "/data/nomad"
datacenter = "techops"

log_level = "INFO"
enable_syslog = true

server {
  enabled          = true
  bootstrap_expect = 3
}

#client {
#  enabled = true
#  node_class = "node"
#  network_speed = 10
#  options = {
#    "driver.raw_exec.enable" = "1"
#  }
#}

consul {
	server_service_name = "nomad"
  server_auto_join = true
  client_service_name = "client"
  client_auto_join = true
  auto_advertise = true
}
