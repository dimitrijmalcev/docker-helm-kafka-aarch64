#!/bin/bash




override_command="--override controller.listener.names=CONTROLLER --override listeners=PLAINTEXT://:9092,CONTROLLER://:9093 --override process.roles=broker,controller --override listener.security.protocol.map=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL"
echo "controller.listener.names=CONTROLLER" >> /etc/kafka/server.properties
echo "listeners=PLAINTEXT://:9092,CONTROLLER://:9093" >> /etc/kafka/server.properties
echo "process.roles=broker,controller" >> /etc/kafka/server.properties
echo "listener.security.protocol.map=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT,SSL:SSL,SASL_PLAINTEXT:SASL_PLAINTEXT,SASL_SSL:SASL_SSL" >> /etc/kafka/server.properties

if [ -z $KAFKA_BROKER_ID ]; then echo ""
else  
  override_command=$override_command" --override node.id=$KAFKA_BROKER_ID --override broker.id=$KAFKA_BROKER_ID"
  echo "node.id=$KAFKA_BROKER_ID" >> /etc/kafka/server.properties
  echo "broker.id=$KAFKA_BROKER_ID" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_ZOOKEEPER_CONNECT ]; then echo ""
else  
  override_command=$override_command" --override zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT"  
  echo "zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_BOOTSTRAP_SERVERS ]; then echo ""
else  
  override_command=$override_command" --override --bootstrap-server=$KAFKA_BOOTSTRAP_SERVERS"  
  echo "bootstrap-server=$KAFKA_BOOTSTRAP_SERVERS" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_ADVERTISED_PORT ]; then echo ""
else  
  override_command=$override_command" --override advertised.port=$KAFKA_ADVERTISED_PORT"  
  echo "advertised.port=$KAFKA_ADVERTISED_PORT" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_ADVERTISED_HOST_NAME ]; then echo ""
else  
  override_command=$override_command" --override advertised.host.name=$KAFKA_ADVERTISED_HOST_NAME"  
  echo "advertised.host.name=$KAFKA_ADVERTISED_HOST_NAME" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_LOG_RETENTION_HOURS ]; then echo ""
else  
  override_command=$override_command" --override log.retention.hours=$KAFKA_LOG_RETENTION_HOURS" 
  echo "log.retention.hours=$KAFKA_LOG_RETENTION_HOURS" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_LOGS_DIR ]; then echo ""
else  
  override_command=$override_command" --override log.dirs=$KAFKA_LOGS_DIR"  
  echo "log.dirs=$KAFKA_LOGS_DIR" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_ADVERTISED_LISTENERS ]; then echo ""
else  
  override_command=$override_command" --override advertised.listeners=$KAFKA_ADVERTISED_LISTENERS"
  echo "advertised.listeners=$KAFKA_ADVERTISED_LISTENERS" >> /etc/kafka/server.properties
fi

if [ -z $KAFKA_LISTENERS ]; then echo ""
else  
  override_command=$override_command" --override listeners=$KAFKA_LISTENERS,$KAFKA_CONTROLLER_LISTENERS" 
  echo "listeners=$KAFKA_LISTENERS,$KAFKA_CONTROLLER_LISTENERS" >> /etc/kafka/server.properties 
fi

if [ -z $KAFKA_CONTROLLER_QUORUM_VOTERS ]; then echo ""
else  
  override_command=$override_command" --override controller.quorum.voters=$KAFKA_CONTROLLER_QUORUM_VOTERS"  
  echo "controller.quorum.voters=$KAFKA_CONTROLLER_QUORUM_VOTERS" >> /etc/kafka/server.properties 

fi

if [ -z $KAFKA_CLUSTER_ID ]; then echo ""
else  
  kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c /etc/kafka/server.properties
fi

kafka-server-start.sh /etc/kafka/server.properties $override_command