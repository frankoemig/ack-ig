<style>
table th {background: #779bf0}
table tr:nth-child(even) {background: #EEE}
table tr:nth-child(odd) {background: #FFF}
</style>

How to deal with ACK codes?

### Defined Codes

What codes are currently defined?

| Code | Description | Follow-up |
| --- | --- | --- |
| AA | message is accepted and processed, perhaps some minor issues, but no major errors | none |
| AE | message contains minor errors and is at least partially processed | resubmit erroneous data in a new or updated message |
| AR | message contains major errors and is not processed | The errors must be fixed and the complete message has be to resent. |

### Scenarios ...

... with regard to what kind of acknowledgement is sent will certainly vary ...

#### ... with complex messages

A complex message will try to address several aspects in general.
For example, an ADT admission message will

* register the patient, ie. create or update the patient record
* create a new admission
* create or update
  * insurance data
  * diagnosis data
  * additional observations
  * ...

##### Option 1

This option tries to process as much as possible and keeps that information stored. 
The sender can take the most important details from the acknowledgement code.


| Code | Description | Follow-up | Precondition |
| --- | --- | --- | --- |
| AA | The message is accepted and processed, the record with all details has been created. No major errors are discovered.| none |
| AE | The message contains errors, also on "important data" with regard to subsequent aspects. It is partially processed so that the main record has been created. | The erroneous data has to be resubmitted in more specialised messages, eg. an update to diagnosis etc. | Dedicated errors must be defined so that it is clear which part is not accepted. It is clear that some data has been stored. |
| AR | The message contains major errors and is not processed | The errors must be fixed and the complete message has be to resent. |


##### Option 2

Alternatively, even with minor issues on substantive content the message can be rejected ("AR"). 
Then the list of warnings and errors must be checked to identify what needs correction.

| Code | Description | Follow-up | Precondition |
| --- | --- | --- | --- |
| AA | message accepted |
| AE | Only minor issues that do not affect important data. |
| AR | Issues on important data lead to reject the message. | All errors must be corrected and the message has to be resent. |

#### ... with simple messages

A simple message will try to address only one specific aspect.
Therefore, such a message is much smaller, and easier to process.
Consequently, responses can be more fine tuned.
Taking the above example, different messages for each aspect would be created and sent.

| Code | Description | Follow-up |
| --- | --- | --- |
| AA | The message is accepted and processed, no major errors | none |
| AE | The message contains minor errors and is partially processed. This will probably not happen because the message is finegrained and every aspect is declared important. | resubmit erroneous data in a new message |
| AR | The message contains major errors and is not processed. | The errors must be fixed and the complete message has be to resent. |


### Soft and Hard Errors

An important aspect is the distinction into soft and hard errors.
In other words, what is an error that must be corrected, but does not lead to reject a message?
And which error is so severe that the message cannot be processed?

### Detailed Error Indication

Another question is which type of error can be contained in what response:

| Type | AA | AE | AR | Comment |
| --- | --- | --- | --- | --- |
| infos | x | x | x | infos may appear in every response |
| warning | x | x | x | same for warnings |
| soft error | a) | x | x | soft errors may not prevent from (partial) successful processing of the message |
| hard error | - | b) | x | a hard error must be present on a rejection, but it can be accepted in a partial processing. However, that must be corrected. |

a) Small/minor errors can be issued even if the message returns an "AA". But hard errors are not allowed.

b) It is debatable whether hard errors will lead to a partial processing of a message ("AE"), or a total rejection ("AR"). 
Both has some arguments.
