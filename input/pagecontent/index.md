### Overview

The ACK Management Framework describes different interactions and codes that control 
how acknowledgements are handled.

### Basic Interaction

The primary purpose of acknowledgements is the communication to the sender 
how far the incoming message could be processed.
In principle, it may consist of three different levels:

1: physical (correct) receipt of the message
2: conformance testing against basic, formally specified criteria
3: processing of content

<div width="500px">
{% include Basic-ACK.svg %}
</div>

Many (perhaps most) systems do not perform a dedicatd/separated conformance testing.
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

