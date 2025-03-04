<style>
hr {height:10px; border-width:0; color:lightgray; background-color:lightgray}
</style>

### Overview

This page describes different options how sender and receiver may interact.
The primary difference is with or without gateways that forward messages.

<hr/>

### ACKs without Gateways

In a scenario w/o gateways a direct interaction between sender and recipient occurs.

#### Simple Request with Transport ACKs

The easiest use case is to have an interaction between two actors - sender and recipient.
A request is sent and responded with a transport acknowledgement.
It releases the sender from repeating the transmission,
and it does not tell anything about the processing results on receive side.

<div width="500px">
{% include Request_with_Ack_without_Gateways.svg %}
</div>

#### Simple Request with Application ACKs

The other simple option is to communicate with applicatin acknowledgements.
The receiver informs the sender about the processing results.

<div width="500px">
{% include Request-Response_without_Ack_without_Gateways.svg %}
</div>

#### Simple Request with Transport and Application ACKs

The third simple option is the combination of both: transport and application acknowledgement:
The receiver first informs about the receipt of the message thus releasing the sender from repeating.
Afterwards, the receiver returns the processing result which in return is responded by the sender with 
a transport acknowledgement.

<div width="500px">
{% include Request-Response_with_Ack_without_Gateway.svg %}
</div>


<hr/>

### ACKs with Gateways

In a lot of circumstances, gateways are included to forward the message.
In such a case the sender does not directly communicate with the intended recipient 
but using one or more gateways that take care of the messages and forwards them the next recipient
until they reach the final destination.

#### Forwarded Request with Transport ACK

In the simplest use case, each gateway accepts the received message and responds with
a transport acknowledgement, before it forwards the message to the next recipient.
Each sender has to evaluate the response whether he has to resubmit the message:

<div width="500px">
{% include Request_with_Ack_and_Gateways.svg %}
</div>

Because only the transmission is checked not further duties arise.

#### Forwarded Request with Application ACK

In case an application acknowledgement is necessary, the last recipient will start
with the sending back the response:

<div width="500px">
{% include Request-Response_with_Gateways_without_Ack.svg %}
</div>

An application ACK introduces some responsibilities. Therefore, it is reasonable to assume
that the recipient has to take care whether a response has been received:

<div width="500px">
{% include Request-Response_with_Gateways_without_Ack2.svg %}
</div>

#### Forwarded Request with Transport and Application ACK

The same, but in this case also transport ACKs are returned:

<div width="500px">
{% include Request-Response_with_Ack_and_Gateways.svg %}
</div>

Application ACKs introduces again some duties about controlling the overall processing:

<div width="500px">
{% include Request-Response_with_Ack_and_Gateways2.svg %}
</div>

<hr/>

### Service Request with Intermediary

????? to be explained ...

<div width="500px">
{% include ServiceRequest_with_Intermediary.svg %}
</div>


<hr/>

### Asynchronuous Protocol

Some may not know, but HL7 v2 is an asynchronous protocol.
Therefore, messages need not be responded immediately.
Also, the response order may vary or deviate from the sent messages:

#### Request with asynchropnous ACKs

Requests are normally sent in the order they occur. (The correct order is important due to internal states.)
However, the response may be sent in arbitrary orders. The following is just one possible example:

<div width="500px">
{% include Request_with_async_ACKs_without_Gateways.svg %}
</div>

The correlation between initiating and response message is done via the message identifier which is sent in the message header.

<hr/>

### Use Case with Communication Server

The purpose of a communication server is to distribute a single message to different recipients.

#### Single Request with Comserver

In this example, we will distribute a single request to multiple recipients.

The communication server takes the message, and prepares and returns a response that releases
the sender from resending the message.

In a next step, the comserver will update the message for each recipient depending on his indivudal needs:

<div width="500px">
{% include Request_with_Comserver.svg %}
</div>

This scenario does not cover application acknowledgements from individual recipients and how they are 
transmitted back. 

> Question: What to do if some recipients reject the message?

