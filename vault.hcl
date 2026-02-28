storage "raft" {
    path = "/opt/raft"
    node_id = "node1"
    retry_join
    {
        leader_api_addr = "https://node2.int.us-west-1-dev-central.example.com:8200"
        leader_ca_cert_file = "/etc/vault.d/ssl/tls_ca.pem"
        leader_client_cert_file = "/etc/vault.d/ssl/tls_crt"
        leader_client_key_file = "/etc/vault.d/ssl/tls.key"
    }
    retry_join
    {
        leader_api_addr = "https://node3.int.us-west-1-dev-central.example.com:8200"
        leader_ca_cert_file = "/etc/vault.d/ssl/tls_ca.pem"
        leader_client_cert_file = "/etc/vault.d/ssl/tls_crt"
        leader_client_key_file = "/etc/vault.d/ssl/tls.key"
    }
}

listener "tcp" {
    address = "0.0.0.0:8200"
    tls_disable = false
    tls_cert_file = "/etc/vault.d/ssl/tls.crt"
    tls_key_file = "/etc/valult.d/ssl/tls.key"
    tls_client_ca_file = "/etc/vault.d/ssl/tls_ca.pem"
    tls_cipher_suites = "TLS_TEST_128_GCM_SHA256,
                         TLS_TEST_128_GCM_SHA256,
                         TLS_TEST_128_POLY1305,
                         TLS_TEST_256_GCM_SHA384"
}
api_addr = "https://node1.int.us-west-1-dev.central.example.com:8200"
cluster_add = "https://node1.int.us-west-1-dev.central.example.com:8201"
disable_mlock = true
ui = true
log_level = "trace"
disable_cache = true
cluster_name = "POC"

### Enterprise license_path
## This will be required for enterprise as of v1.8
license_path = "/etc/vault.d/vault.hclic"