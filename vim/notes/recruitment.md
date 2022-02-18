# Full stack interview

https://lunarenergy.atlassian.net/wiki/spaces/TechTeam/pages/685604955/Face+to+face+interview+script+full+stack+developer


## Introduction

- Jaime
  Joined Moixa 5 months ago
  Principal software engineer
  I usually work on the backend

- Interview:
  Explore your techincal knowledge
  Will last no more than 2 hours total
  1. Questions
  2. Technical exercise
     Whiteboard exercise
  3. 5-10 minutes for candidate questions

- Questions:
  Are wide in scope,
    it is expected that you won't know the answer to everything
  And we may ask follow up questions
    We do not expect you to be able to answer everything,
    so if you don't know anything just say it.
  We may move the candidate on from a question to keep to time
    that's not a reflection on the quality of the answer

## Questions (45 min)

Questions for the candidate (45min)

!!!
1. What happens when you click a link on a browser

https://github.com/jcabotc/cab_handbook/blob/master/you-at-cabify/recruiting/technical-questions/systems.md

Hardware:
  Right click circuit is closed and induces a current flow
  It is converted into a code
  Which is encoded by the mouse controller to be sent to the computer
  Common transports are USB and bluetooth

OS:
  The signal gets to the mouse interrupt line (IRQ)
  The CPU uses the IDT (Interrupt Descriptor Table) to associate it to a specific function
  Ends up notifying the browser

Event bubbling:
  Targetting to find the element
  Event on an element, it runs the handlers on it, then parent and other ancestors
    `event.target` is the element where the event occurred
    `this` is the current element (same as `event.currentTarget`)
  `event.stopPropagation()` stops the bubbling
  Event will reach the link

DNS resolution:
  - Check local hosts file
  - Requests to the configured DNS server (probably local router or ISP's)
  - ARP (Address resolution protocol) to find the IP of the DNS server1
  - Port 53, UDP (or TCP if response size is too large)
  - If not found recursively searches to the follow up server on the list
  - Eventually reaches SOA (Start of Authority)
  - If found, receives IP and port

Open a socket: ...

Autonomous system:
  AS is a collection of IP prefixes under control of a single administrative entity

TCP roundtrips: ...
TLS (if https): ...
HTTP: ...
Server side: ...

2. At Moixa we like functional programming, with both TypeScript and Haskell. Can you discuss some of the characteristics of functional programming in comparison to object-oriented programming.
see if you used functional programming professionally and know if you developed an intuition on it

Data and behaviour; encapsulated in OO, separate in FP
Side effects (isolation thereof), composability, immutability
Currying
Functor (map) / Applicative (map, pure) / Monads (map, pure, flatten) etc. // Check interfaces
Follow ups
Expand on the characteristics of a so-called "pure" function? (return value determined only by params, no side effects)


!!!
4. Caching is an important strategy for delivering high performance, efficient web services.
   Can you talk about the different places you might use caching across the stack, and what the benefits are?

Browser caching (headers, storage, ServiceWorker)
  Cache-Control: Max-Age  => Amount of time in seconds to expire
  Cache-Control: No-Cache => Browser may cache, but must first validate the request to an origin server
  Cache-Control: No-Store => No cache
  Cache-Control: Public   => May be cached by any cache
  Cache-Control: Private  => User specific cache

Caching proxies (Varnish, Stingray, Squid)

CDNs (Akamai, Fastly) "Content delivery network"
  Caches content in servers that are located closer to end users than origin servers

App level caching (of: DB results, components, full pages; using Redis, Memcached etc.)
hy not in memory

caching in algorithms: memoization (dynamic programming)

Database caching (tuning the DB's use of indexes, temp tables, other in-memory features that reduce disk I/O)

Follow up on layers they haven't mentioned


!!!
5. We make extensive use of APIs for sharing data, can you describe the characteristics a well designed REST API?

We're looking for

Use of HTTP verbs (idempotent except POST and PATCH (patch can be but it is optional))

Statelessness (perhaps with the exception of auth)

Use of headers for caching, content negotiation, auth
  Caching: see above
  Content negotiation: (Content-type specifies the actual type, not the negotiation)
    Client:
      Accept: Client accepted content type
      Accept-Encoding: gzip, compress, etc
      Accept-Language: language and locale
      Usef-Agent: Identifies the client sending the request

Authentication approaches (Basic auth, HMAC, OAuth(2))
  Basic auth: "Authorization: Basic <username:password base64 encoded>"
  HMAC:
    Shared secret (exchanged by the parties) 
    2 keys derived from the secret (inner and outer)
    hash of the message+innerKey and hash of the result+outer key
    final hash sent alongside the message
  Oauth2:
    User authenticates against the API provider
    and gives a service the right to claim a token
    that token is used to auth against API provider

Versioning approaches (evolutionary, version in url)

Potential follow up: How might a load balancer handle the HTTP verbs differently?


!!!
6. How do you go about testing web applications?
We're looking for

Use of tools like Browserstack for automation cross-browser
  Tests on 3000+ browsers and devices

Visual regression automation like Wraith
  Highlights visual differences between screenshots at different moments in time

Functional testing (Cucumber/RSpec, BDD frameworks in general)

Unit testing

Screen readers, contrast tools for accessibility

Strategic manual testing (the most flaky browsers first, understanding the riskiest parts of the codebase for regressions)

Follow up
What steps do you take to ensure your work is accessible to all users?


7. At Moixa we like to keep our applications secure in the browser. In that context I wonder if you can talk a bit about security exploits and vulnerabilities on the web?

We're looking for
HTTP header which defines cross-origin resource sharing policy ("access-control-allow-origin")
Enables secure cross-origin resource sharing
Security mitigation for CSRF
Prevents arbitrary JS execution by XSS attacks
Content types which are vulnerable
Follow up question
If you're not familiar with CORS then can you talk about any other HTTP headers for security you are aware of? (CSP, HSTS, X-Frame-Options)
What online resources would you go to sharpen your knowledge? (OWASP, MDN, securityheaders.io etc.)


!!!
8. We handle a lot of data at Moixa. Please compare the characteristics of relational and document databases,
giving examples of when might you choose to use each?

Relational good for data that you want to query and compose in lots of different ways

Optimise for read vs optimise for write

How well is the schema known? Will it be changing often?

Do you care about consistency or availability more (CAP).

Relational delivers consistency over availability, document vice versa (ACID vs BASE).
  ACID: Atomic, Consistent, Isolated, Durable
  BASE: Basically Available (rather than immediate consistency), Soft state, Eventually consistent

Follow up:
How you would optimise for slow queries: index, shard, cache etc.


9. If you had to learn a new technical skill what would it be? Why would you be interested in it? What project might you apply it to?

We're looking

Enthusiasm for new tech
Good sense of how to apply tech to a project
How do they think about tech and developing their skills?
Follow up
What stops you doing it now?

--------------

thank you for staying with us on this round of questions

## Pause (5 min)

## Exercise (IoT infrastructure)

it is about communication
feel free to speak your mind,
ask any questions you think are relevant

You have been asked to propose the architecture for a new IoT platform.

The system must:
- Ingest data from a large set of IoT devices of various types
- The devices will send similar data in different input formats

The data needs to be:
- Processed in various different ways
- Queried in real time by a variety of client applications.

Please provide a high-level view of a complete system, proposing appropriate technologies you would use. These can be vendor-specific cloud technologies or not.












# Screening interview

## Remember

- Feels comfortable
- Keep on time, ensure can ask questions
- Help show himself in the best light
- Consider his seniority
- Represent Moixa in the best way possible

* Answer should be yes/no

## Interview

- Introduce myself:

  Jaime
  Joined Moixa 5 months ago
  Principal software engineer
  I usually work on the backend

- Interview for FUNCTIONAL DEVELOPER ROLE at MOIXA

  Will last no more than 30 min
  * I'll tell you a bit about the company and the technologies we use
  * I'll ask 2 or 3 questions that will take 20 min
    On those questions I'm interested in examples of things you've done
  * 5 mins at the end for you to ask questions


- Moixa:

  * We develop smart batteries,
    Optimize the cost of energy consumption by remotely managing those batteries
  * To do so,
    we FORECAST expected production and consumption,
    based on typical consumption patterns on each site,
    and other factors like weather forecast
  * And we tell the battery how to behave to optimize the cost,
    based on that forecast, the price to import/export power from the grid,
    etc
  * We provide UIs to our clients to monitor their batteries behavior.


- Technologies:

  * Rust for the embedded software that runs on the batteries
  * Typescript for most of the backend,
    we use a functional-programming library (called fp-ts),
    and all the code on the backend is functional,
    (to be honest, I don't know how to define a class in Typescript, I should check it)
  * Python for the machine learning part,
    because of the extensive collection of libraries for ML
  * Backend code runs on AWS lambda,
    we don't manage servers,
    we don't need a devops team


Q1: Describe a time when you were working in a team and solved a challenging technical problem

  * Architecture, tech details?
  * Teamwork?
  * Did it work on the long term?
  * Simpler solution? Was it needed?


Q2: Describe a time when you made a positive change within a team,
    for example by introducing a new technology, a new practice,
    or by influencing the way the team worked together

  * How did the team react?
  * What was the impact?


Q3: Describe a time when you implemented the wrong thing,
    perhaps a technology choice, architecture or design pattern.

  * How did you realise it wasn't right?
  * How did you go about resolving the situation? 
  * What did you do differently?

Q(if remote): If you end up joining Moixa. What country would you work from?

## Candidate questions

* Holiday is 25 days + bank holidays
* Personal L&D budget of £1000 plus 4 days paid time, this can be used for any relevant conferences and courses
* Private Health Insurance
* Enhanced Maternity + Paternity Pay
* Enhanced sickness pay
* Hybrid working: able to work in the office for your chosen number of days or be fully remote, working from your preferred location within the UK.
* It may be possible to work compressed hours, i.e. 4 x 9 hour days instead of a traditional 5-day week
