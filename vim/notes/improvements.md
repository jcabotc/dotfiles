# Tools

- Add fzf to terminal for file completion

# Flex

- Make usef-server step function to poll to check if all market participants already sent their offers instead of waiting far more to make sure they arrived
- Move all timezone period logic into a single place (startOfDay, periodInterval, etc)
- Make everything idempotent (for example, a flex order may be stored on the server, but fail when the client receives it)

# Planner

- Make it pure: it receives an input and returns an output (no persistence or side effects)
    Currently some data is read/written from both typescript and python (2 different implementations)

# Remove USEF from internal workflows

## Complexities of using USEF internally

- Usef & flex datatypes (for example: FlexRequest and PrognosisDiffRequest)
- Multiple ways to identify a resource (for example for a flex group: id and congestionPoint)
- Unnecessary fields for flex group participants (congestionPoint, domains, etc)
- Due to the weird usage of USEF some fields doesn't make sense (server role is DSO, but it is not a DSO)
- Adds complexity to the protocol used to communicate server and clients (restricted to XML, http requests, separate request and response messages, etc)
- Logic that should be on flex domain (like USEF client prognosis generation, or USEF server prognosis aggregation) is on USEF domain, therefore USEF entities depend on flex entities (for example: on flex group to get the timeZone)
- Deal with USEF issues:
  * Domains can't have capitals, but sites have
  * Public keys should be created in every region
- All logs for a single event in one place (now we have to follow different log streams from multiple stacks)

## Site and aggregate prognosis generation

* It happens:
  - Recurrently on generateMany
  - On device updated plan
  - On flex order (needed? plan will be updated anyway)

- Current:
  = usef-client stack
    - Fetch relevant flex groups, and usef clients
    - Calculate a prognosis for all clients
    - Transform every prognosis into a USEF prognosis
    - Store every USEF prognoses on usef-client table
    - Deliver every USEF prognosis (HTTP XML request to USEF server)
  = usef-server stack
    - Handle HTTP updated USEF prognosis request, and queue it into a SQS queue
    - Consume SQS message:
    - Store USEF prognosis for a client on usef-server table
    - Send HTTP response back (usef-client responds with 200)
  = usef-server stack (recurrently)
    - Fetch all flex groups
    - Fetch all usef-client prognoses for each congestionPoint (flex group)
    - Aggregate all client prognoses
    - Fetch last aggregated prognosis for that congestionPoint
    [If aggregated prognosis changed] 
    - Store aggregated prognosis and associations on usef-server table
    - Publish a SNS message to notify updated prognosis (consumed by flex-rebalance)

- Proposal:
  = flex-prognosis stack
    - Fetch relevant flex groups and participants
    - Calculate a prognosis for all participants
    - Store prognosis for each participant on flex table
    - Aggregate all client prognoses
    - Fetch last aggregated prognosis for that congestionPoint
    [If aggregated prognosis changed] 
    - Store aggregated prognosis and associations on flex table
    - Publish a SNS message to notify updated prognosis (consumed by flex-rebalance)

## Market cycle

* It happens on flex requests from partner, and on rebalancing events

- Current:
  = usef-partner-api-4, or flex-rebalance
    - build USEF flex request (add USEF specific metadata)
    - send HTTP request to usef-server
  = usef-server stack
    - Handle HTTP -> SQS ->
    - trigger market cycle step-function:
    - Store flex request on usef-server table
    - Fetch referenced aggregated and participant prognoses
    - Queue an ongoing flex request for each usef-client referencing its prognosis on SQS
    - Consume each one and send a HTTP flex request to each client
    - Wait for offers (fixed amount of time)
  = usef-client stack (one per client)
    - Handle HTTP flex-request:
    - Store flex-request on usef-client table
    - Start flex-request step-function:
    - Fetch prognosis, flexGroup, invocations, contracts, for the trader 
    - Run trader
    - Store flex offers on usef-client table
    - Send HTTP request to usef-server with all client offers
  = usef-server stack (one per client)
    - Handle HTTP -> SQS ->
    - Send HTTP offer response
    - Store client flex offers on usef-server table
  = usef-server stack (after waiting for a fixed amount of time)
    - Fetch flex request, client flex offers, for the offer trader
    - Run offer trader
    - Build a aggregated offer from trader output accepted offers
    - Store aggregated flex offer and accepted client offers on usef-server table

- Proposal
  = usef-partner-api-4, or flex-rebalance
    - trigger flex market-cycle step-function
  = flex-market-cycle stack (that defines the step function)
    - Store flex request on flex table
    - Fetch referenced aggregate and participant prognoses
    [On a lambda in parallel for each participant] <- For USEF AGR this lambda interacts with the third-party instead through USEF messages
    - Fetch prognosis, flexGroup, invocations, contracts, for the trader
    - Run trader
    [Once all participant lambdas finished]
    - Store all flex offers for all clients
    - Run offer trader
    - Build a aggregated offer from trader output accepted offers
    - Store aggregated flex offer and accepted client offers on usef-server table

## Flex order

* It happens on flex orders from partner, and on rebalancing events

- Current:
  = usef-partner-api-4, or flex-rebalance:
    - Build USEF flex order
    - Send HTTP flex order to usef-server
  = usef-server:
    - Handle HTTP -> SQS ->
    - Store aggregated and participant flex orders on usef-server table
    - Send HTTP flex request per usef-client
  = usef-client (one per participant)
    - Store flex order on usef-client table
    - Get planner problem, store constraints, apply invocation (update device plan)
    - trigger participant prognosis recalculation

- Proposal:
  = usef-partner-api-4, or flex-rebalance:
    - Trigger flex order step-function
  = flex-market cycle stack
    - Store aggregated and participant flex orders on flex table
    [On a lambda in parallel for each participant] <- For USEF AGR this lambda interacts with the third-party insetad through USEF messages
    - Get planner problem, store constraints, apply invocation (update device plan)
    - trigger participant prognosis recalculation
