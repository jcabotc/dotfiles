# Dorian

API endpoint to get the CSV

# Prepare for sunrun contracts

- Generic lambda to execute all contracts, not only PCE 
  Remove old contracts
  Use new contracts for actionWindows too
  Remove old actionWindows code

- Check if we want "pce" contractType for all skyline flex groups
- Event ids for flex requests

- Partner-UI-triggered flex requests with actionWindows that match the flex request
- Add to market participant logs missbehaviour info
- Revoke flex orders. How hard is it?
- API to trigger them

## Show flex constraints on partner
ActionWindow is the most relevant, but all of them would be great

## CSV and flex? groups page
Check jesus chat

## Jesus on rebalancing
check rebalancing flow is tested and UI shows it




## HomeResponse: External market participant
Gather all the info needed:
  USEF domain, url, public key
  - USEF domain: ???
  - USEF role: AGR
  - USEF url: ???
  - publicKey: ??? // Base64 encoded would be nice (should be kms encoded to store it on dynamo)

Flex offer revocations not supported, and flex offer expiration time ignored

### USEF server info:
domain: `moixa-usef.com`
role: `DSO`
url: `https://t4b0f35jmd.execute-api.eu-west-1.amazonaws.com/dev/api/v1/usef/server/incoming`
publicKey (base64): `CwYzFdC2cgAxac-nLZXXQWLTBtvNq6W06SMJpDu3SIg`

### Account and flex group
New partner account:
```
profile: moixa-dev
region: eu-west-1
stage: dev
account_name: home_response
account_display_name: Home Response
user_email: johnathan.linfoot+homeresponse@moixa.com
account_id: 54cba745-1b4c-456b-bf98-bcc59def9bd5
account_user_id: f59a607c-5097-4e83-930c-6bb18fab3b48
partner_user_pool_id: eu-west-1_x04wINbIx
parent_group_name: partner_owner_superadmin
partner_owner_group_name: partner_owner_home_response
```

Password for johnathan.linfoot+homeresponse@moixa.com: Password1$

New flex group:
```
account_name: home_response
account_id: 54cba745-1b4c-456b-bf98-bcc59def9bd5
congestionPoint: ea1.2021-09.home-response-DEV.cloud:004
display_name: HomeResponse-Flex-Dev
public_key: homeresponse-public-key-placeholder

group name: partner_dim_home_response_flexPool_8c39a9e5-c522-43d8-a259-a6c683ca2939
```
