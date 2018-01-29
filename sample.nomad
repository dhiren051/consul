job "sleepj" {
	type = "service"
  datacenters = ["techops"]
  group "sleepg" {
    task "sleept" {
      driver = "raw_exec"
      config {
       command = "/home/ubuntu/scheduler/script.bash"
       args = []
      }
    }
  }
}
