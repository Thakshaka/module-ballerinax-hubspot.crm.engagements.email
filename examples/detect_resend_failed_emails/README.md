## Detect and resend failed emails

This use case demonstrates how the HubSpot CRM Engagements Email API can be used to identify and resend emails that have failed or bounced. By leveraging the API, this approach automates the detection and resending process, ensuring important communications reach their intended recipients without manual intervention.

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