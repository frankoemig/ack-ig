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

* #AA "application accept"
* #AE "application error"
* #AR "application reject"




ValueSet: AckCodesVS
Id: AckCodes
Title: "ACK Codes"
Description: "**OACK Codes**"

* ^url = "http://ackig.oemig.de/fhir/ValueSet/AckCodes"
* ^version = "0.1.0"

* insert HeaderDetailRules

* include codes from system http://ackig.oemig.de/fhir/CodeSystem/AckCodes




