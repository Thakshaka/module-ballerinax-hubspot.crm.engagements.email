_Author_:  Thakshaka Rathnayake \
_Created_: 2025/02/14 \
_Updated_: 2025/02/15 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from HubSpot CRM Engagements Email. 
The OpenAPI specification is obtained from [Hubspot Github Public API Spec Collection](https://github.com/HubSpot/HubSpot-public-api-spec-collection/blob/main/PublicApiSpecs/CRM/Emails/Rollouts/424/v3/emails.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Change the `url` property of the servers object
- **Original**:
`https://api.hubapi.com`

- **Updated**:
`https://api.hubapi.com/crm/v3/objects/emails`

- **Reason**: This change of adding the common prefix `crm/v3/objects/emails` to the base url makes it easier to access endpoints using the client.

2. Update the API Paths
- **Original**: Paths included common prefix above in each endpoint. (eg: `/crm/v3/objects/emails/search`)

- **Updated**: Common prefix is now removed from the endpoints as it is included in the base URL.

- **Reason**:  This change simplifies the API paths, making them shorter and more readable.

3. Change `"date-time"` to `"datetime"` throughout the specification
- **Original**: 
```json 
    "format": "date-time"
4. Update the API summaries and descriptions to make them more meaningful

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --license docs/license.txt --mode client -o ballerina
```
Note: The license year is hardcoded to 2024, change if necessary.