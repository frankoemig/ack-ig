### Overview

The ACK Management Framework describes different interactions and codes that control 
how acknowledgements are handled.

### ACKs without Gateways

#### Simple Request (w/ transport ACK)

The easiest use case is to have an interaction between two actors - sender and recipient.
A request is sent and responded with an ack.

<div width="500px">
{% include Request_with_Ack_without_Gateways.svg %}
</div>

#### Request + Application Response without transport ACK

<div width="500px">
{% include Request-Response_without_Ack_without_Gateways.svg %}
</div>

#### Request with Application Response

<div width="500px">
{% include Request-Response_with_Ack_without_Gateway.svg %}
</div>



### ACKs with Gateways

In a lot of circumstances, gateways are included to forward the message.

####  Request

In the simplest use case, each gateway accepts the received message and responds with
a transport acknowledgement, before it forwards the message to the next recipient:

<div width="500px">
{% include Request_with_Ack_and_Gateways.svg %}
</div>

####  Request + Application Response without transport ACK

In case an application acknowledgement is necessary, the last recipient will start
with the sending back the response:

<div width="500px">
{% include Request-Response_with_Gateways_without_Ack.svg %}
</div>

#### Request + Application Response

The same, but in this case also transport ACKs are returned:

<div width="500px">
{% include Request-Response_with_Ack_and_Gateways.svg %}
</div>



### Service Request with Intermediary

????? to be explained ...

<div width="500px">
{% include ServiceRequest_with_Intermediary.svg %}
</div>



### Asynchronuous Protocol

Some may not know, but HL7 v2 is an asynchronuous protocol.
Therefore, messages need not be responded immediately.
Also, the response order may vary or deviate from the sent messages:

#### Request with async ACKs without Gateways

<div width="500px">
{% include Request_with_async_ACKs_without_Gateways.svg %}
</div>

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

