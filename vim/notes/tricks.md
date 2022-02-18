# Dynamo prognosis keys

- Aggregate prognosis seq for DSO from here:
pk: `LATEST_USEF_PROGNOSIS#ea1.2018-03.moixa-test.cloud:004#PERIOD#2021-07-27`

- Find associations:
pk: `USEF_PROGNOSIS_AGGREGATE#202107271050445380027`

- See specific prognosis:
pk: `USEF_PROGNOSIS#202107270802448855927`

# Generate prognoses for flex groups

- EnqueueBetaPlannerBatch lambda:
```json
{
    "payload": {
        "group": {
            "attributes": {
                "flex": "true"
            }
        }
    },
    "configuration": {
        "doTimeCorrection": true
    }
}
```

# AWS CLI examples

- Update devices attributes:
```bash
aws \
  --region us-west-1 \
  --profile moixa-dev \
  iot search-index \
    --index-name "AWS_Things" \
    --max-results 500 \
    --query-string "thingGroupNames:partner_dim_sunrun_flexPool_29a53e9f-24bd-4b84-8582-47c25351beee" | jq -rc '.things[] | .thingName' | grep 'GATEWAY' > /tmp/foo && cat /tmp/foo | xargs -I{} aws \
    --region us-west-1 \
    --profile moixa-dev iot update-thing \
    --thing-name {} \
    --attribute-payload "{\"attributes\":{\"planDispatchable\":\"true\"},\"merge\":true}"
```

- List things in things group:
```bash
aws \
  --region eu-west-1 \
  --profile moixa-prod \
  iot list-things-in-thing-group \
    --thing-group-name partner_dim_home_response_flexPool_bc7b2eb0-90b4-4170-8a7e-7ea3456b6458 \
    | jq '.things[]' \
    | xargs -I \
    aws \
      --region eu-west-1 \
      --profile moixa-prod \
      iot describe-thing \
        --thing-name {}
```

# Logs

Find lambda:
`AWS_PROFILE=moixa-dev AWS_REGION=us-west-1 awslogs groups | grep usef-client`

Tail -f logs:
`AWS_PROFILE=moixa-dev AWS_REGION=us-west-1 awslogs get -w /aws/lambda/gridshare-usef-client-dev-HandleUsefRequests`

# AWS Profiles

Dev: `moixa-development`
Prod: `moixa-prod`
Sunrun-dedicated dev: `741947186778`
Sunrun-dedicated prod: `566262158588`

# Find devices in flex group
```
AWS_PROFILE=moixa-dev aws --region us-west-1 iot search-index --query-string "thingGroupNames:partner_dim_sunrun_flexPool_8897bd41-3e8c-457f-9c41-6e059fc1ed09 AND thingTypeName:VirtualGenericSkylineESS"  | jq '{deviceId: .things[].thingName}'
```

# Flex scripts

Set attributes to devices on a flex group:
```
I_KNOW_WHAT_I_AM_DOING=1 \
AWS_PROFILE=moixa-prod \
AWS_REGION=eu-west-1 \
pnpm exec ts-node scripts/flex/setDeviceAttributesForGroup.ts
```

Set attributes to sites on a flex group:
```
I_KNOW_WHAT_I_AM_DOING=1 \
AWS_PROFILE=moixa-prod \
AWS_REGION=eu-west-1 \
USEF_ENTITY_TABLE=gridshare-usef-server_usef_entity_table_prod \
DYNAMODB_USEF_ENTITY_GSI1_INDEX=gridshare-usef-server_usef_entity_table_gsi1_prod \
pnpm exec ts-node scripts/flex/setSitesAttributesForGroup.ts
```

# USEF scripts

Encode usef message
```
SIGNING_PRIVATE_KEY=7kMtr5rvTUmmrvJjs4a5hUB20UzMQ6S7TiodW--J1kY1Lqa4bfT4dYIQ7SpeWRbtlXAaYhp117fIS1_pRZKLJg \
pnpm exec ts-node scripts/flex/encodeUsefMessage
```

Decode usef message
```
SIGNING_PUBLIC_KEY=CwYzFdC2cgAxac-nLZXXQWLTBtvNq6W06SMJpDu3SIg \
pnpm exec ts-node scripts/flex/decodeUsefMessage
```

Send USEF message
```
I_KNOW_WHAT_I_AM_DOING=1 \
AWS_PROFILE=moixa-dev \
AWS_REGION=eu-west-1 \
SIGNING_PRIVATE_KEY=7kMtr5rvTUmmrvJjs4a5hUB20UzMQ6S7TiodW--J1kY1Lqa4bfT4dYIQ7SpeWRbtlXAaYhp117fIS1_pRZKLJg \
USEF_ENTITY_TABLE=gridshare-usef-server_usef_entity_table_dev \
GRIDSHARE_DATA_KMS_KEY_ID=68ed2c49-c11c-450b-ae32-bc4eba1c8ec9 \
pnpm exec ts-node scripts/flex/sendUsefMessage
```

Get flex order events history csv (PCE example)
```
AWS_PROFILE=moixa-prod \
AWS_REGION=us-west-1 \
FLEX_ORDER_EVENTS_TABLE=gridshare-flex-order-events_flex_order_event_prod \
CONGESTION_POINT="ea1.2021-09.skyline-PCE-PROD.cloud:004" \
CSV_PATH="../../../results.csv" \
pnpm exec ts-node scripts/flex/generateOrderEventsCsv
```

# Nuc Docker issues
```
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
```

# Create flex group
```
AWS_PROFILE=moixa-dev \
AWS_REGION=us-west-1 \
python scripts/create_partner_flex_pool_group.py \
  sunrun \
  0b092492-c483-11eb-842e-af05d81e665b \
  ea1.2021-09.skyline-PCE-PROD.cloud:004 \
  PCE-Flex-Prod
```
Script args:
1. Account name
2. Account id
3. Congestion point
4. Display name 

# Dynamo market participants
Test2 group inverter market participant
```
{
    "pk": "USEF_ENTITY#lambda-mock-v4-battery-1.moixa-usef.com#USEF_ROLE#AGR",
    "sk": "METADATA",
    "data": {
        "usefEntityKind": "client",
        "privateKey": null,
        "metadata": {
            "deviceId": "lambda_mock_v4_battery_1",
            "kind": "inverter"
        },
        "role": "AGR",
        "domain": "lambda-mock-v4-battery-1.moixa-usef.com",
        "publicKey": "AQICAHjOzLqstLLeLXIpLN6EVjNnHjIHjKqO4DdnN8aC4NpyfAGPe455ONsVzoSdjk26dr5NAAAAijCBhwYJKoZIhvcNAQcGoHoweAIBADBzBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDH8gAPabfHwN3grrIgIBEIBGe8leArV3OvybQIdWBYEZmwQy+WB1k1wy98Z2hpqtzQbkoONRZhRrf85UcGRia/Qg1DTYirC5gbX1Ad2hlLRFwRR5wJ6ZSw==",
        "url": "https://2mliw55vea.execute-api.eu-west-1.amazonaws.com/dev/api/v1/usef/client/incoming"
    }
}
```
```
{
    "pk": "USEF_ENTITY#lambda-mock-v4-battery-1.moixa-usef.com#USEF_ROLE#AGR",
    "sk": "USEF_CLIENT_CONGESTION_POINT#ea1.2018-03.moixa-test.cloud:004",
    "g1pk": "USEF_CLIENT_CONGESTION_POINT#ea1.2018-03.moixa-test.cloud:004",
    "data": {
        "usefEntityKind": "client",
        "privateKey": null,
        "metadata": {
            "kind": "inverter",
            "deviceId": "lambda_mock_v4_battery_1"
        },
        "role": "AGR",
        "domain": "lambda-mock-v4-battery-1.moixa-usef.com",
        "publicKey": "AQICAHjOzLqstLLeLXIpLN6EVjNnHjIHjKqO4DdnN8aC4NpyfAENS/eaqC344do3UXisqGoeAAAAijCBhwYJKoZIhvcNAQcGoHoweAIBADBzBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDJNxqP1dFjLL46o2lgIBEIBGtYGp4VaAlMoZA/DM8DeT+QqiY5K+nZsFfvnIPxMmsa5QpPGFKUSRsIhv4etNU+XUDQbtq89KRsQ6w32wXo6/00LqbNVNNg==",
        "url": "https://2mliw55vea.execute-api.eu-west-1.amazonaws.com/dev/api/v1/usef/client/incoming"
    },
    "g1sk": "USEF_ENTITY#lambda-mock-v4-battery-1.moixa-usef.com#USEF_ROLE#AGR"
}
```

# Set tariffs
```
aws --region us-west-1 --profile moixa-prod iot search-index --max-results 500 --index-name "AWS_Things" --query-string "thingGroupNames:partner_dim_sunrun_flexPool_dcc591c9-0cb8-456f-b96a-0c2c582ea4de" | jq -rc '.things[]' > /tmp/dev_devices

cat /tmp/dev_devices | jq -rc '.thingGroupNames[] | select(contains("site-"))' | sort | uniq  > /tmp/dev_sites_clean

./scripts/set-tariffs.sh
```

# Setup flex group
- Set correct `flexCurrency` and `flexTimeZone` on the aws iot things group
- Set correct flex contract and actionWindows
- Upload market participants CSV
- Set tariffs to all market participants (as shown above)
- Run planner for all flex groups through enqueueBeta... lambda (wait for the Planner to finish)
- Run GenerateMany prognoses
- Run prognosis aggregation

