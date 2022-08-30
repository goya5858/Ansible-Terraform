1. Generate KeyPair
```
ssh-keygen -N "" -f ec2_key
```

2. ssh to EC2
```
ssh -i <path/to/pem-key> <host>@<ip-adress>
```