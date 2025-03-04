<style>
table th {background: #f0b033}
table tr:nth-child(even) {background: #EEE}
table tr:nth-child(odd) {background: #FFF}
</style>

How are messages represented in different standards:

### v2 Messaging

In v2.x messaging is the standard transmission protocol. The content is encapsulated by technical segments:

(simple) trigger message:

* MSH
* [EVN]
* PID
* ...

response ACK message:

* MSH
* MSA
* ...

MSH conveys individual message instance identifiers.
In a response, the MSA refers to the instance identifier of the message to which it is the response to.

### FHIR Messaging

In FHIR, messages are transmitted in a batch that is encapsulated in a bundle:

* Bundle
  * MessageHeader
  * ...

### V3 Messaging

> Is V3 Messaging still an issue to be covered and explained?
