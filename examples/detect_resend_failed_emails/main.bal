// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/oauth2;
import ballerinax/hubspot.crm.engagements.email as hsceemail;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

hsceemail:OAuth2RefreshTokenGrantConfig auth = {
    clientId,
    clientSecret,
    refreshToken,
    credentialBearer: oauth2:POST_BODY_BEARER
};

hsceemail:Client hubspot = check new ({auth});

public function main() returns error? {

    // Define properties to retrieve (fetch email status)
    string[] properties = ["hs_email_status", "hs_email_text", "hs_email_subject", "hs_email_headers"];

    // Get all emails
    hsceemail:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/.get(properties = properties);

    foreach hsceemail:SimplePublicObject email in response.results {
        string? emailStatus = email?.properties["hs_email_status"];

        // Resend the email if it has failed or bounced
        if emailStatus == "FAILED" || emailStatus == "BOUNCED" {
            string emailText = email?.properties["hs_email_text"] ?: "";
            string emailSubject = email?.properties["hs_email_subject"] ?: "";
            string emailHeaders = email?.properties["hs_email_headers"] ?: "";

            // Attempt to resend the email
            hsceemail:SimplePublicObject newEmail = check hubspot->/.post({
                associations: [
                    {
                        types: [],
                        to: {
                            id: "84058501871"
                        }
                    }
                ],
                objectWriteTraceId: "string",
                properties: {
                    "hs_email_status": "SENDING",
                    "hs_email_subject": emailSubject,
                    "hs_email_text": emailText,
                    "hs_email_headers": emailHeaders
                }
            });

            io:println(string `Resent email with new ID: ${newEmail.id}, Subject: ${emailSubject}`);
        }
        io:println(string `Email ${email.id} is not FAILED or BOUNCED. Skipping...`);
    }
}
