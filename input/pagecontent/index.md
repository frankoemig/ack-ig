<style>
table th {background: #f0b033}
table tr:nth-child(even) {background: #EEE}
table tr:nth-child(odd) {background: #FFF}
</style>

### Overview

The ACK Management Framework describes different interactions and codes that control 
how acknowledgements are handled.

Primarily, the following is expected:

![Basic Requirements](requirements.png){:height="400px"}
<br clear="all"/>  

A recipient has to consume the message, and create a response in return, that documents the receipt 
of the message as well as detailed information from its internal processing. The level depends on whether
the transports could be done successfully and/or the conformance testing as well as processing could happen.

In addition, some details are neccessary to specify what should be done with the data.
This belongs to [obligations](obligations.html), which should  be discussed 
in a [separate specification](https://build.fhir.org/ig/frankoemig/obligation/) but not here.

### Basic Interaction

The primary purpose of acknowledgements is the communication to the sender 
how far the incoming message could be processed.
In principle, it may consist of three different levels:

1. physical (correct) receipt of the message
2. conformance testing against basic and formally specified criteria (normally not done)
3. processing of content

<div width="500px">
{% include Basic-ACK.svg %}
</div>

Many (perhaps most) systems do not perform a dedicated/separated conformance testing.
They process the messages on-the-fly by simply trying to process it.
Therefore, the result of conformance testing can be returned as a accept/transport acknowledgement, 
or as the first part of processing, then returning an application acknowledgement.

### Primary Responsibilities

The primary responsibility, among the physical transport (via files, sockets, etc.) and the verification
of the physical completeness and correctness of the content, are following:

1. response to the sender about the processing of the message
  a. physical (transport/accept) acknowledgements
  b. conformance verification
  c. processing of the message content
2. returning a detailed list of findings (information, notes, warnings, errors) for receiving or processing of the message
3. specifying details about what should happen with (parts of) the message
  a. aka [obligations](obligations.html)

### Primary Response

The response from a recipient to a sender my concentrate on two different facts:

|Application <br/>ACK:|<br/>Meaning|1: <br/>focus is on internal state of recipient |record stored|2: <br/>focus is on action needed by sender|  record stored|
| --- | --- | --- | --- |
| <b>AA<b/> |Accept|All information was accepted.<br/>No further action needed.|yes|Information was accepted and record has been created.<br/>No further action needed.|yes|
| <b>AE<b/> |Error |Some information was accepted and processed.<br/>It is recommended to send an updated message for the outstanding details.|yes|Message hasn't been processed, only minor errors are detected, but resubmission is necessary.|no|
| <b>AR<b/> |Reject|No information was accepted for any reason.<br/>If necessary, an updated message must be sent.|no|Important details are wrong and fixes are required and resubmission is necessary or critical.|no|

Both options have their pros and cons and are equally valid.
