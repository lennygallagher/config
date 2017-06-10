# Start Kafka
Start Zookeeper cluster and Kafka cluster.
```./startKafka.sh```

Create a topic:
```
docker run \
  --net=host \
  --rm \
  confluentinc/cp-kafka:3.2.1 \
  kafka-topics --create --topic bar --partitions 3 --replication-factor 3 --if-not-exists --zookeeper localhost:32181
```

Test if the topic is created:
```
docker run \
    --net=host \
    --rm \
    confluentinc/cp-kafka:3.2.1 \
    kafka-topics --describe --topic bar --zookeeper localhost:32181
```
```
Topic:bar	PartitionCount:3	ReplicationFactor:3	Configs:
	Topic: bar	Partition: 0	Leader: 1003	Replicas: 1003,1001,1002	Isr: 1003,1001,1002
	Topic: bar	Partition: 1	Leader: 1001	Replicas: 1001,1002,1003	Isr: 1001,1002,1003
	Topic: bar	Partition: 2	Leader: 1002	Replicas: 1002,1003,1001	Isr: 1002,1003,1001
```