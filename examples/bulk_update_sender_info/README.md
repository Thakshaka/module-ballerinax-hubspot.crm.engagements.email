## Bulk update sender information in scheduled emails

This use case demonstrates how the HubSpot CRM Engagements Email API can be used to update the sender information for all scheduled emails. By leveraging the endpoints of the HubSpot CRM Engagements Email API, this approach automates a task that would otherwise be time-consuming if done manually.

## Prerequisites

### 1. Setup Hubspot developer account

Refer to the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.email/blob/main/README.md#setup-guide) to obtain necessary credentials (client id, client secret, tokens).

### 2. Configuration

Create a `Config.toml` file in the example's root directory and, provide your Hubspot account related configurations as follows:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```