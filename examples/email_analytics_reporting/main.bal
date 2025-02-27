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

    // Define the properties to be fetched
    string[] properties = ["hs_email_status"];

    // Get all email engagements
    hsceemail:CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/.get(properties = properties);

    // Initialize analytics counters
    int totalSent = 0;
    int totalBounced = 0;
    int totalFailed = 0;
    int totalScheduled = 0;

    foreach hsceemail:SimplePublicObject email in response.results {
        string? emailStatus = email?.properties["hs_email_status"];

        // Update counters based on email status
        match emailStatus {
            "SENT" => {
                totalSent = totalSent + 1;
            }
            "BOUNCED" => {
                totalBounced = totalBounced + 1;
            }
            "FAILED" => {
                totalFailed = totalFailed + 1;
            }
            "SCHEDULED" => {
                totalScheduled = totalScheduled + 1;
            }
            _ => {
                // Ignore other statuses
            }
        }
    }

    // Print the analytics summary
    io:println("===== Email Engagements Report =====");
    io:println(string `Total Emails Sent    : ${totalSent}`);
    io:println(string `Total Emails Bounced : ${totalBounced}`);
    io:println(string `Total Emails Failed  : ${totalFailed}`);
    io:println(string `Total Emails Scheduled    : ${totalScheduled}`);
}
