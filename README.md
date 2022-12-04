# Docker and Helm Chart for kafka on ARM (aarch64) architecture by Dimitrij Malcev 

Provides a Dockerfile and a basic helm chart for Kafka usage on aarch64 architecture (for example on a raspberry pi version 4) for development purposes by Dimitrij Malcev.

# Build 

- `cd build`
- `docker buildx build --platform linux/arm64 -t <tag> .`

# Deployment

Information: no zookeeper is needed for this deployment since this kafka version works without zookeeper

Please customize the following values in `templates/kafka-statefulset.yaml`:

- `image` 
- `KAFKA_CONTROLLER_LISTENERS`
- `KAFKA_LISTENERS`
- `storageClassName`

`helm upgrade --install kafka charts/kafka`

# Additional information 

only for development usage

# Todo

- make more options configurable in the values
- provide more configuration options in entrypoint