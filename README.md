## set environment vars on all nodes
export VAULT_ADDR=https://$(hostname):8200
export VAULT_CACERT=/etc/vault.d/ssl/tls_ca.pem
export CA_CERT=`cat /etc/vault.d/ssl/tls_ca.pem`

## start vault as a service on all nodes

cat /etc/systemd/system/vault.service
systemctl enable vault.service
systemctl start vault.service
systemctl status vault.service

## check vault status on all nodes
vault status

## Initialize vault with following cmd on vault node1 only. store unseal keys securely
vault operator init -key-shares=1 -key-threshold=1

## Set Vault token environment variable for the vault CLI command to authenticate to the server. Use the following command, replacing <initial-root- token> with the value generated in the previous step.
export VAULT_TOKEN=<initial-root-token>
echo "export VAULT_TOKEN=$VAULT_TOKEN" >> /root/.bash_profile
## Repeat this step for the other 2 servers.

## Unseal Vault1 using the unseal key generated in step 10. Notice the Unseal Progress key-value change as you present each key. After meeting the key threshold, the status of the key value for Sealed should change from true to false.
vault operator unseal ABC/jfoiejlajf385jl

## Unseal Vault2 (Use the same unseal key generated in step 10 for Vault1):
vault operator unseal ABC/jfoiejlajf385jl
vault status

## Check the cluster's raft status with the following command:
vault operator raft list-peers

## Currently, node1 is the active node. We can experiment to see what happens if node1 steps down from its active node duty.

In the terminal where VAULT_ADDR is set to: https://node1.int.us-west-1-dev.central.example.com, execute the step-down command.

vault operator step-down ## equivalent of stopping the node or stopping systemctl service

## In the terminal, where VAULT_ADDR is set to https://node2.int.us-west-1-dev.central.example.com:8200, examine the raft peer set.

vault operator raft list-peers

## Also, we can shut down the active vault instance (sudo systemctl stop vault) to simulate a system failure and see the standby instance assumes the leadership.
