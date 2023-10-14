step ca init --deployment-type=standalone --name=SCEP-CA --dns=localhost --address=:9000 --provisioner=prov --password-file=./pw
step certificate create --password-file=./pw --profile root-ca --kty RSA --size 4096 'SCEP CA' $(step path)/certs/root_ca.crt $(step path)/secrets/root_ca_key
step certificate create --ca-password-file=./pw -password-file=./pw --profile intermediate-ca --kty RSA --size 4096 --ca $(step path)/certs/root_ca.crt --ca-key $(step path)/secrets/root_ca_key 'Intermediate SCEP CA' $(step path)/certs/intermediate_ca.crt $(step path)/secrets/intermediate_ca_key
cp ./pw $(step path)/secrets/password
step ca provisioner add scepprov --type SCEP --challenge "secret12345" --encryption-algorithm-identifier 0
sed -i 's/"insecureAddress": "",/"insecureAddress": ":9001",/' $(step path)/config/ca.json