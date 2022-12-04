# docker-helm-kafka-aarch64 by Dimitrij Malcev

Provides a Dockerfile and a basic helm chart for kafka usage on aarch64 architecture (for example on a raspberry pi version 4)

# Build 

`cd build`
`docker buildx build --platform linux/arm64 -t <tag> .`
