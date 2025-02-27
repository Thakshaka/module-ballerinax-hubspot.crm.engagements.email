## Examples

The `HubSpot CRM Engagements Email` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.email/tree/main/examples/), covering the following use cases:

1. [Bulk Update Sender Information in Scheduled Emails](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.email/tree/main/examples/bulk_update_sender_info/) - Automate the process of updating sender information for all scheduled emails, ensuring accuracy and consistency in email communication.

2. [Detect and Resend Failed Emails](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.email/tree/main/examples/detect_resend_failed_emails/) - Identify emails with a status of "FAILED" or "BOUNCED" and attempt to resend them, ensuring important messages reach their intended recipients.

3. [Email Analytics and Reporting](https://github.com/ballerina-platform/module-ballerinax-hubspot.crm.engagements.email/tree/main/examples/email_analytics_reporting/) - Retrieve and analyze key email performance metrics such as sent, bounced, failed, and scheduled emails to monitor delivery status and optimize communication strategies.

## Prerequisites

1. Generate Hubspot credentials to authenticate the connector as described in the [Setup guide](../ballerina/Package.md#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId = "<client-id>"
    clientSecret = "<client-secret>"
    refreshToken = "<refresh-token>"
    ``` 

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
