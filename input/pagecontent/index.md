<style>
table th {background: #f0b033}
table tr:nth-child(even) {background: #EEE}
table tr:nth-child(odd) {background: #FFF}
</style>

### Overview

Problem Description: The HL7 standard specifications, especially v2.x, lacks a common understanding
how acknowledgements are used. A thorough investigation reveals different options.

The ACK Management Framework describes different interactions and codes that control 
how acknowledgements are handled. It tries to identify different options how that can be achieved.

Primarily, the following is expected:

![Basic Requirements](requirements.png){:height="400px"}
<br clear="all"/>  

A recipient has to consume the message, and create a response in return, that documents the receipt 
of the message as well as detailed information from its internal processing. The level depends on whether
the transport could be done successfully and/or the conformance testing as well as processing could happen.

In addition, some details are neccessary to specify what should be done with the data.
This belongs to [obligations](obligations.html), which should  be discussed 
in a [separate specification](https://build.fhir.org/ig/frankoemig/obligation/) but not here.

### Possible Options

The use of the message response code in MSA allows for epressing  the results in different ways 
in combinations with the error code in ERR:

![Possible Options](options.png){:height="400px"}
<br clear="all"/>  

#### Indication in Message Header

The result of the investigations for this IG provides two options that are explained later.

It is a good idea to express the two use behavior by an appropriate profile identifier in MSH-21.

### Critical Data

In HL7 v2 messaging, critical data refers to the core information elements required to fulfill 
the business purpose of the message—not merely to satisfy structural correctness. 
While message conformance defines required fields based on the HL7 grammar and segment rules, 
critical data is defined by the use case and the expectations of the sending and receiving systems.

![Critical Data](critical_data.png){:height="400px"}
<br clear="all"/>  

For example, in a message intended to register a new entity (e.g., a patient, order, or observation), 
critical data may include the identifier, the subject of the transaction, 
and the essential attributes needed to create or update the corresponding record. 
If these elements are missing, unrecognized, or rejected, the message fails in its primary purpose, 
even if the message is structurally valid.

The definition of critical data should be clearly documented in the Implementation Guide (IG) 
that governs the specific transaction type. In some implementations, this definition has been left implicit, 
relying on shared assumptions between trading partners. However, this guidance recommends making it explicit, 
so that message acknowledgment behavior—such as ACK codes and ERR segment severity—can be tied directly 
to whether the critical data was successfully processed.

Understanding critical data is essential for defining meaningful response patterns. 
It allows systems to differentiate between issues that block core functionality and 
those that affect supplemental or optional information, enabling more precise communication and action.

### Reframing Conformance Checking

Conformance checking is not formally a part of runtime message processing, 
though it may be implemented by some systems. It plays a valuable role during system development, 
testing, certification, and interface onboarding, where adherence to HL7 and implementation guide constraints 
can help ensure consistent message structure and interoperability.

However, conformance validation should not, on its own, prevent business-level processing of valid and actionable data. 
In production environments, systems SHALL process a message if its critical data can be interpreted and applied, 
even if the message contains structural or syntactic deviations from the formal specification.

It is acceptable to log or report conformance issues, and systems may reflect these in ACK messages. 
But the presence of conformance issues must not be treated as a sufficient reason to reject a message, 
unless those issues result in loss or corruption of critical business data. 
Systems should not assume or require that all successful transmissions be completely free of conformance deviations 
in order to function correctly.

For this reason, conformance checking is not modeled as a formal level of message processing in this framework. 
Instead, the focus is placed on evaluating whether the business-critical content of the message was successfully 
processed, which is the most meaningful basis for determining acknowledgment outcomes.

### Definition of "Processed"

Processed refers to the degree to which the receiving system has interpreted and acted upon 
the business-relevant content of an HL7 message. It reflects meaningful engagement with 
the message—not just parsing its syntax, but applying its information to support the intended workflow.

This concept is not tied to any specific system architecture. 
Different systems may process messages in different ways internally. 
The model below is presented as a common reference framework to describe outcomes 
consistently in acknowledgements—it should not be interpreted as a mandate for implementation design.

### Conceptual Levels of Processing

To support consistent messaging between systems, we distinguish the following categories 
based on how much of the message was successfully processed:

**Fully Processed**
All data in the message—critical and non-critical—was successfully applied by the receiving system.

**Critical Data Processed**
The essential data elements necessary for the business purpose (e.g., 
registering a patient and storing a vaccination) were successfully processed. 
Non-critical elements may have had issues, but the primary use case was fulfilled.

**Critical Data Not Processed**
One or more issues prevented the system from applying the data necessary to fulfill the business purpose. 
For example, a missing or unrecognized vaccine code could prevent a vaccination from being stored.

**Nothing Processed**
No part of the message could be meaningfully applied—either because the message was structurally invalid, 
key identifiers were unresolvable, or all data failed validation.

These categories can be used to guide the construction of acknowledgements (e.g., MSA-1 and ERR-4 values) 
that inform the sender of what action is required—whether to monitor, update/fix the source, or resubmit the message.


### Hard Errors vs. Soft Errors

The terms "hard error" and "soft error" are sometimes used informally to describe the severity or impact of problems detected in an HL7 message. While this terminology is not formally defined in HL7 standards, it can be mapped to the processing model described above:

  * Hard Error: An error that results in the failure to process critical data. This type of error prevents the receiving system from fulfilling the business purpose of the message (e.g., the patient could not be registered, or a vaccination could not be stored). These errors typically require resubmission of corrected data, as essential information has been lost.

  * Soft Error: An error where the critical data was successfully processed, but some non-critical data could not be applied. For example, a phone number or address may have been rejected due to formatting issues. While these errors should be addressed to maintain data quality, no immediate resubmission is required.

This mapping provides a more structured way to interpret soft vs. hard errors and helps avoid confusion by aligning them with clearly defined system behaviors.


### Partial Processing and ACK Behavior

In HL7 message exchange, it is common for a receiving system to successfully apply some parts of a message 
while rejecting others due to data quality issues. However, the ACK framework does not provide a standardized, 
definitive mechanism to communicate exactly which parts of the message were processed and which were not. 
While error segments (ERR) can indicate where problems were detected, they do not guarantee precise insight 
into what was stored versus discarded.

Because of this, systems must make an architectural decision about how to handle messages with partial issues. 
Two models are generally used:

1. Permissive Processing Model (Supports Reprocessing)

In this model, the receiving system may apply some valid parts of the message, even if other parts are rejected. 
If critical data was not processed, the sender is instructed to resubmit the entire message after correction. 
The receiver must therefore be capable of:

* Idempotent behavior: handling repeated submissions of the same data without duplication or corruption.

* Reconciling partial updates: tolerating and integrating overlapping or redundant data updates.

This model supports partial acceptance but places a burden on the receiver to gracefully handle repeated submissions 
and potential overlap.

2. All-or-Nothing Model (No Reprocessing)

In this model, if any portion of the message fails validation—particularly if critical data is affected—the 
entire message is rejected. No updates are applied until a corrected message is received and can be fully processed. 
This ensures data integrity in systems where:

* Duplicate or out-of-order submissions cannot be cleanly handled.

* Partial data application risks creating inconsistent or incomplete records.

In this model, reliability comes from conservative behavior, even if that means rejecting otherwise 
useful non-critical data.

Key Point

The choice between these models rests entirely with the receiver. 
The ACK message signals what action the sender should take, but it does not define or 
expose the internal handling logic of the receiving system. As such, 
the receiver is responsible for deciding whether to process part of a message or none, 
based on its architecture, business requirements, and tolerance for duplicate data.

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

|Application <br/>ACK:|<br/>Meaning|Option 1: <br/>focus is on internal state of recipient |record stored|Option 2: <br/>focus is on action needed by sender|  record stored|
| --- | --- | --- | --- |
| <b>AA<b/> |Accept|All information was accepted.<br/>No further action needed.|yes|Information was accepted and record has been created.<br/>No further action needed.|yes|
| <b>AE<b/> |Error |Some information was accepted and processed.<br/>It is recommended to send an updated message for the outstanding details.|yes|Message hasn't been processed, only minor errors are detected, but resubmission is necessary.|no|
| <b>AR<b/> |Reject|No information was accepted for any reason.<br/>If necessary, an updated message must be sent.|no|Important details are wrong and fixes are required and resubmission is necessary or critical.|no|

Both options have their pros and cons and are equally valid.

### Contributors

* Nathan Bunker
* Frank Oemig
* Rob Snelick

