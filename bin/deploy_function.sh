INPUT_TOPIC="persistent://rtk/test/simple-input"
INPUT_SUB="simple-input-sub"
OUTPUT_TOPIC="persistent://rtk/test/simple-output"
FUNCTION_NAME="SimpleFunctionRtk"

echo "Creating tenant and namespace"

./pulsar-admin tenants create rtk
./pulsar-admin namespaces create rtk/test

echo "INPUT"

./pulsar-admin topics create-partitioned-topic --partitions 1 $INPUT_TOPIC
# no retention, remove immediately after acknowledged
./pulsar-admin topics create-subscription $INPUT_TOPIC -s $INPUT_SUB

./pulsar-admin schemas upload \
    --filename /pulsar/functions/schema.json \
    $INPUT_TOPIC

echo "OUTPUT"

./pulsar-admin topics create-partitioned-topic --partitions 1 $OUTPUT_TOPIC
./pulsar-admin topics set-retention -s -1 -t -1 $OUTPUT_TOPIC

./pulsar-admin schemas upload \
    --filename /pulsar/functions/schema.json \
    $OUTPUT_TOPIC

echo "FUNCTION"

./pulsar-admin functions create \
    --jar /pulsar/functions/pulsar-simple-function.jar \
    --classname pl.trojczak.pulsar.function.SimpleFunction \
    --tenant rtk \
    --namespace test \
    --name $FUNCTION_NAME \
    --inputs $INPUT_TOPIC \
    --subs-name $INPUT_SUB \
    --output $OUTPUT_TOPIC \
    --cpu 1.0