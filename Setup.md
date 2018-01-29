# Setup EC2

## Configure EC2
* relaxed security groups, for time being

## Setup linux
* add mc1,mc2,mc3 aliases for private AWS-IP for each m/c
```
sudo vim /etc/hosts
```
* login to m/cs
```
sudo ssh -i ~/.ssh/devopsdm.pem -r ubuntu@mc2
```

# Setup Consul
## Run Latest consul
Issue: OS Installed consul version is 0.5.2. Latest version is 1.0.2.

* stop running consul.
```
ps -aef | grep -i consul
sudo kill -INT <consul-pid>
```

* Download latest consul binary. run it instead. bootstrap the consul cluster
```
wget https://releases.hashicorp.com/consul/1.0.2/consul_1.0.2_linux_amd64.zip
unzip <downloaded-zip>

# On each m/c, execute following. Note: ensure the directories listed in server.json are created
sudo consul agent -config-file /data/consulconfig/server/server.json -node <mc-name:mc1/2/3> -client <mc-ip> -ui
```

[reference](https://www.consul.io/docs/guides/bootstrapping.html)

# Setup Nomad

[bootstrap nomad cluster](https://www.nomadproject.io/guides/cluster/automatic.html)

After [setting up consul](#setup-consul), do following
* stop OS installed nomad
```
sudo systemctl stop nomad-server
sudo systemctl stop nomad-client
```
* create server config (./server.hcl)
* get latest nomad
* run nomad with the config
```
sudo nomad agent -config=./server.hcl -node=<nomad-name:mc1/2/3> -consul-address="mc-ip|host-alias:8500"
```
* run nomad with client config (client.hcl)
```
sudo nomad agent -config=client.hcl -node=mc3-client -consul-address=mc3:8500
```

# Troubleshooting

* If there is an error, reset raft data
```
sudo rm -rf /data/consul/*
```

# TODO

* ~~install nomad~~
* ~~integrate with consul~~
* schedule a job
