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

import ballerina/http;
import ballerina/oauth2;
import ballerina/test;

configurable string clientId = "client-id";
configurable string clientSecret = "client-secret";
configurable string refreshToken = "refresh-token";
configurable boolean isLiveServer = false;

string testEmailId = "";
string testBatchId = "";

configurable string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/objects/emails" : "http://localhost:9090";

final Client hubspot = check initClient();

isolated function initClient() returns Client|error {
    if isLiveServer {
        OAuth2RefreshTokenGrantConfig auth = {
            clientId: clientId,
            clientSecret: clientSecret,
            refreshToken: refreshToken,
            credentialBearer: oauth2:POST_BODY_BEARER
        };
        return check new ({auth}, serviceUrl);
    }
    return check new ({
        auth: {
            token: "test-token"
        }
    }, serviceUrl);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
public function testCreateEmailEp() returns error? {
    // Create a new email
    SimplePublicObject response = check hubspot->/.post({
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
            "hs_timestamp": "2025-10-30T03:30:17.883Z",
            "hubspot_owner_id": "77405866",
            "hs_email_direction": "EMAIL",
            "hs_email_status": "SENT",
            "hs_email_subject": "Let's talk about Ballerina",
            "hs_email_text": "Thanks for your interest let's find a time to talk",
            "hs_email_headers": "{\"from\":{\"email\":\"from@domain.com\",\"firstName\":\"FromFirst\",\"lastName\":\"FromLast\"},\"sender\":{\"email\":\"sender@domain.com\",\"firstName\":\"SenderFirst\",\"lastName\":\"SenderLast\"},\"to\":[{\"email\":\"ToFirst+ToLast<to@test.com>\",\"firstName\":\"ToFirst\",\"lastName\":\"ToLast\"}],\"cc\":[],\"bcc\":[]}"
        }
    });

    // Store the id of the created email for use in other testcases
    testEmailId = response.id;

    // Check if the response contains the created email
    test:assertEquals(response?.properties["hs_email_subject"], "Let's talk about Ballerina", msg = "Incorrect email subject");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateEmailEp]
}
public function testGetAllEmailsEp() returns error? {
    // Retrieve all emails
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspot->/.get();
    test:assertTrue(response.results.length() > 0, "No emails found");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateEmailEp]
}
public function testGetAEmailEp() returns error? {
    // Define the required properties as an array
    string[] properties = ["hs_email_subject"];

    // Retrieve test email
    SimplePublicObjectWithAssociations response = check hubspot->/[testEmailId].get(properties = properties);
    test:assertEquals(response?.properties["hs_email_subject"], "Let's talk about Ballerina", msg = "Incorrect email subject");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateEmailEp]
}
public function testUpdateEmailEp() returns error? {
    // Update email properties
    SimplePublicObject response = check hubspot->/[testEmailId].patch({
        properties: {
            "hs_email_subject": "Let's talk about Ballerina Language"
        }
    });

    // Check if the response contains the updated email subject
    test:assertEquals(response?.properties["hs_email_subject"], "Let's talk about Ballerina Language", msg = "Incorrect email subject");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateEmailEp]
}
public function testDeleteEmailEp() returns error? {
    // Delete an email
    http:Response response = check hubspot->/[testEmailId].delete();

    // Check if the response status is 204 (No Content)
    test:assertEquals(response.statusCode, 204);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
public function testCreateBatchEp() returns error? {
    // Create a new batch
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/create.post({
        inputs: [
            {
                associations: [
                    {
                        types: [
                            {
                                "associationCategory": "HUBSPOT_DEFINED",
                                "associationTypeId": 198
                            }
                        ],
                        to: {
                            "id": "84058501871"
                        }
                    }
                ],
                properties: {
                    "hs_email_attached_video_opened": "false",
                    "hs_email_attached_video_watched": "false",
                    "hs_email_direction": "EMAIL",
                    "hs_lastmodifieddate": "2025-02-18T09:49:46.220Z",
                    "hs_timestamp": "2025-02-18T09:49:46.220Z"
                }
            }
        ]
    });

    // Store the id of the created batch for use in other testcases
    testBatchId = response.results[0].id;

    test:assertEquals(response.results[0].properties["hs_email_direction"], "EMAIL", msg = "Incorrect email direction");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateBatchEp]
}
public function testReadBatchEp() returns error? {
    // Define the required properties as an array
    string[] properties = ["hs_email_direction"];
    string[] propertiesWithHistory = ["hs_email_direction"];

    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/read.post({
        propertiesWithHistory: propertiesWithHistory,
        inputs: [
            {
                id: testBatchId
            }
        ],
        properties: properties
    });

    test:assertEquals(response.results[0].properties["hs_email_direction"], "EMAIL", msg = "Incorrect email direction");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateBatchEp]
}

public function testUpdateBatchEp() returns error? {
    // Update batch properties
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspot->/batch/update.post({
        inputs: [
            {
                id: testBatchId,
                properties: {
                    "hs_email_direction": "FORWARDED_EMAIL"
                }
            }
        ]
    });

    // Check if the response contains the updated email direction
    test:assertEquals(response.results[0].properties["hs_email_direction"], "FORWARDED_EMAIL", msg = "Incorrect email direction");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateBatchEp]
}
public function testArchiveBatchEp() returns error? {
    http:Response response = check hubspot->/batch/archive.post({
        inputs: [
            {
                id: testBatchId
            }
        ]
    });

    // Check if the response status is 204 (No Content)
    test:assertEquals(response.statusCode, 204);
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    dependsOn: [testCreateBatchEp]
}

public function testSearchEmailsEp() returns error? {
    // Search for emails
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspot->/search.post({});

    test:assertTrue(response.total > 0, "No emails found");
}
