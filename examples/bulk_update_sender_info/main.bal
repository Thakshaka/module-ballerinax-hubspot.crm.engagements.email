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

    // Get all emails
    string[] properties = ["hs_email_status"];
    hsceemail:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/.get(properties = properties);

    final string newSenderEmailAddress = "new_sender_address@example.com";
    final string newSenderFirstName = "SenderFirst";
    final string newSenderLastName = "SenderLast";

    foreach hsceemail:SimplePublicObject email in response.results {
        string? emailStatus = email?.properties["hs_email_status"];

        // Apply the change only to SCHEDULED emails
        if emailStatus == "SCHEDULED" {
            string updatedHeaderInfo = string `{
                "sender": {
                    "email": "${newSenderEmailAddress}",
                    "firstName": "${newSenderFirstName}",
                    "lastName": "${newSenderLastName}"
                }
            }`;

            hsceemail:SimplePublicObject updated = check hubspot->/[email.id].patch({
                properties: {
                    "hs_email_headers": updatedHeaderInfo
                }
            });

            io:println(string `Updated email ${updated.id}'s sender address to ${newSenderEmailAddress}`);
        }
        io:println(string `Email ${email.id} is not SCHEDULED. Skipping...`);
    }
}
