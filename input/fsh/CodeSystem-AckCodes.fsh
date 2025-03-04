CodeSystem: AckCodesCS
Id: AckCodes
Title: "ACK Codes"
Description: "**ACK Codes** (for temporary use only; to be replaced later on)"

* ^url = "http://ackig.oemig.de/fhir/CodeSystem/AckCodes"
* ^version = "0.1.0"

* insert HeaderDetailRules

* ^caseSensitive = false
* ^valueSet = "http://ackig.oemig.de/fhir/ValueSet/AckCodes"
* ^hierarchyMeaning = #is-a
* ^compositional = false
* ^versionNeeded = false
* ^content = #complete


* ^property[+].code = #type
* ^property[=].uri = "http://ackig.oemig.de/fhir/CodeSystem/Property#type"
* ^property[=].description = "What is the type of acknowledgement?"
* ^property[=].type = #code
* ^property[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/codesystem-property-valueset"
* ^property[=].extension[=].valueCanonical = "http://ackig.oemig.de/fhir/ValueSet/AckType"

* ^property[+].code = #response
* ^property[=].uri = "http://ackig.oemig.de/fhir/CodeSystem/Property#response"
* ^property[=].description = "What is the response it conveys?"
* ^property[=].type = #code
* ^property[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/codesystem-property-valueset"
* ^property[=].extension[=].valueCanonical = "http://ackig.oemig.de/fhir/ValueSet/ResponseType"

* ^property[+].code = #status
* ^property[=].uri = "http://hl7.org/fhir/concept-properties#status"
* ^property[=].description = "Status"
* ^property[=].type = #code


* #application "application ACK"
  * ^property[+].code = #status
  * ^property[=].valueCode = #inactive
  * #AA "application accept"
    * ^property[+].code = #type
    * ^property[=].valueCode = #application
    * ^property[+].code = #response
    * ^property[=].valueCode = #positive
  * #AE "application error"
    * ^property[+].code = #type
    * ^property[=].valueCode = #application
    * ^property[+].code = #response
    * ^property[=].valueCode = #neutral
  * #AR "application reject"
    * ^property[+].code = #type
    * ^property[=].valueCode = #application
    * ^property[+].code = #response
    * ^property[=].valueCode = #negative
  
* #transport "transport ACK"
  * ^property[+].code = #status
  * ^property[=].valueCode = #inactive
  * #CA "commit accept"
    * ^property[+].code = #type
    * ^property[=].valueCode = #transport
    * ^property[+].code = #response
    * ^property[=].valueCode = #positive
  * #CE "commit error"
    * ^property[+].code = #type
    * ^property[=].valueCode = #transport
    * ^property[+].code = #response
    * ^property[=].valueCode = #neutral
  * #CR "commit reject"
    * ^property[+].code = #type
    * ^property[=].valueCode = #transport
    * ^property[+].code = #response
    * ^property[=].valueCode = #negative



ValueSet: AckCodesVS
Id: AckCodes
Title: "ACK Codes"
Description: "**ACK Codes**"

* ^url = "http://ackig.oemig.de/fhir/ValueSet/AckCodes"
* ^version = "0.1.0"

* insert HeaderDetailRules

* include codes from system http://ackig.oemig.de/fhir/CodeSystem/AckCodes


//========================================================================================

CodeSystem: PropertyCS
Id: Property
Title: "Property"
Description: "possible Property Values"

* ^url = "http://ackig.oemig.de/fhir/CodeSystem/Property"
* ^version = "0.1.0"

* insert HeaderDetailRules

* ^valueSet = "http://ackig.oemig.de/fhir/ValueSet/Property"

* ^caseSensitive = true
* ^compositional = false
* ^versionNeeded = false
* ^content = #complete

* #type "type"
* #response "response"



ValueSet: PropertyVS
Id: Property
Title: "Property"
Description: "**Property**"

* ^url = "http://ackig.oemig.de/fhir/ValueSet/Property"
* ^version = "0.1.0"

* insert HeaderDetailRules

* include codes from system http://ackig.oemig.de/fhir/CodeSystem/Property


//========================================================================================

CodeSystem: AckTypeCS
Id: AckType
Title: "Ack Type"
Description: "Type of Acknowledgement"

* ^url = "http://ackig.oemig.de/fhir/CodeSystem/AckType"
* ^version = "0.1.0"

* insert HeaderDetailRules

* ^valueSet = "http://ackig.oemig.de/fhir/ValueSet/AckType"

* ^caseSensitive = true
* ^compositional = false
* ^versionNeeded = false
* ^content = #complete

* #application "application"
* #transport "transport"



ValueSet: AckTypeVS
Id: AckType
Title: "Ack Type"
Description: "**Ack Type**"

* ^url = "http://ackig.oemig.de/fhir/ValueSet/AckType"
* ^version = "0.1.0"

* insert HeaderDetailRules

* include codes from system http://ackig.oemig.de/fhir/CodeSystem/AckType


//========================================================================================

CodeSystem: ResponseTypeCS
Id: ResponseType
Title: "Response Type"
Description: "Response Type"

* ^url = "http://ackig.oemig.de/fhir/CodeSystem/ResponseType"
* ^version = "0.1.0"

* insert HeaderDetailRules

* ^valueSet = "http://ackig.oemig.de/fhir/ValueSet/ResponseType"

* ^caseSensitive = true
* ^compositional = false
* ^versionNeeded = false
* ^content = #complete

* #positive "positive"
* #neutral "neutral"
* #negative "negative"



ValueSet: ResponseTypeVS
Id: ResponseType
Title: "Response Type"
Description: "**Response Type**"

* ^url = "http://ackig.oemig.de/fhir/ValueSet/ResponseType"
* ^version = "0.1.0"

* insert HeaderDetailRules

* include codes from system http://ackig.oemig.de/fhir/CodeSystem/ResponseType
