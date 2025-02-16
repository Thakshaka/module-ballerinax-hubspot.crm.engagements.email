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

import ballerina/oauth2;
import ballerina/os;
import ballerina/test;
import ballerina/http;
import ballerina/io;

final string clientId = os:getEnv("HUBSPOT_CLIENT_ID");
final string clientSecret = os:getEnv("HUBSPOT_CLIENT_SECRET");
final string refreshToken = os:getEnv("HUBSPOT_REFRESH_TOKEN");

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string serviceUrl = isLiveServer ? "https://api.hubapi.com/crm/v3/objects/emails" : "http://localhost:8081";

final Client hubspotClient = check initClient();

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

// Change this value and test
final int days = 30;

string testEmailId = "";
string testBatchId = "";

@test:Config {
    groups: ["mock_tests"]
}
public function testCreateEmailEp() returns error? {
    // Create a new email. Will throw error if the response type is not SimplePublicObject
    SimplePublicObject response = check hubspotClient->/.post({
        "properties": {
            "hs_timestamp": "2025-10-30T03:30:17.883Z",
            "hubspot_owner_id": "47550177",
            "hs_email_direction": "EMAIL",
            "hs_email_status": "SENT",
            "hs_email_subject": "Let's talk about Ballerina",
            "hs_email_text": "Thanks for your interest let's find a time to talk",
            "hs_email_headers": "{\"from\":{\"email\":\"from@domain.com\",\"firstName\":\"FromFirst\",\"lastName\":\"FromLast\"},\"sender\":{\"email\":\"sender@domain.com\",\"firstName\":\"SenderFirst\",\"lastName\":\"SenderLast\"},\"to\":[{\"email\":\"ToFirst+ToLast<to@test.com>\",\"firstName\":\"ToFirst\",\"lastName\":\"ToLast\"}],\"cc\":[],\"bcc\":[]}"
        },
        "associations": [
            {
            "to": {
                "id": "601"
            },
            "types": [
                {
                "associationCategory": "HUBSPOT_DEFINED",
                "associationTypeId": 210
                }
            ]
            },
            {
            "to": {
                "id": "602"
            },
            "types": [
                {
                "associationCategory": "HUBSPOT_DEFINED",
                "associationTypeId": 198
                }
            ]
            }
        ]
    });

    // Store the id of the created email for use in other testcases
    testEmailId = response.id;
    io:println("testEmailId: ", testEmailId);
}

@test:Config {
    groups: ["mock_tests"],
    dependsOn: [testCreateEmailEp]
}
public function testGetAllEmailsEp() returns error? {
    CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = check hubspotClient->/.get();
    test:assertTrue(response.results.length() > 0);
}

@test:Config {
    dependsOn: [testCreateEmailEp],
    enable: isLiveServer
}
public function testRetrieveEmailEp() returns error? {
    // Retrieve test email
    SimplePublicObjectWithAssociations response = check hubspotClient->/[testEmailId];
    test:assertEquals(response.id, testEmailId);
}

@test:Config {
    dependsOn: [testCreateEmailEp],
    enable: isLiveServer
}
public function testUpdateEmailEp() returns error? {
    // Update email properties
    _ = check hubspotClient->/[testEmailId].patch({
        "properties": {
            "hs_timestamp": "2025-10-30T03:30:17.883Z",
            "hubspot_owner_id": "47550177",
            "hs_email_direction": "EMAIL",
            "hs_email_status": "SENT",
            "hs_email_subject": "[UPDATED] Let's talk about Ballerina",
            "hs_email_text": "Thanks for your interest let's find a time to talk",
            "hs_email_headers": "{\"from\":{\"email\":\"from@domain.com\",\"firstName\":\"FromFirst\",\"lastName\":\"FromLast\"},\"sender\":{\"email\":\"sender@domain.com\",\"firstName\":\"SenderFirst\",\"lastName\":\"SenderLast\"},\"to\":[{\"email\":\"ToFirst+ToLast<to@test.com>\",\"firstName\":\"ToFirst\",\"lastName\":\"ToLast\"}],\"cc\":[],\"bcc\":[]}"
        }
    });

    // Retrieve the email and check if the properties are updated
    SimplePublicObjectWithAssociations updatedEmail = check hubspotClient->/[testEmailId];
    test:assertEquals(updatedEmail.properties, {
        "hs_timestamp": "2025-10-30T03:30:17.883Z",
        "hubspot_owner_id": "47550177",
        "hs_email_direction": "EMAIL",
        "hs_email_status": "SENT",
        "hs_email_subject": "[UPDATED] Let's talk about Ballerina",
        "hs_email_text": "Thanks for your interest let's find a time to talk",
        "hs_email_headers": "{\"from\":{\"email\":\"from@domain.com\",\"firstName\":\"FromFirst\",\"lastName\":\"FromLast\"},\"sender\":{\"email\":\"sender@domain.com\",\"firstName\":\"SenderFirst\",\"lastName\":\"SenderLast\"},\"to\":[{\"email\":\"ToFirst+ToLast<to@test.com>\",\"firstName\":\"ToFirst\",\"lastName\":\"ToLast\"}],\"cc\":[],\"bcc\":[]}"
    });
}

@test:Config {
    dependsOn: [testCreateEmailEp],
    enable: isLiveServer
}
public function testDeleteEmailEp() returns error? {
    // Delete the created email
    http:Response response = check hubspotClient->/[testEmailId].delete();

    // Check if the response status is 204
    test:assertTrue(response.statusCode == 204);
}

@test:Config {
    groups: ["mock_tests"]
}
public function testCreateBatchEp() returns error? {
    // Create a new batch. Will throw error if the response type is not BatchResponseSimplePublicObject
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspotClient->/batch/create.post({
        "inputs": [
            {
            "associations": [
                {
                "types": [
                    {
                    "associationCategory": "HUBSPOT_DEFINED",
                    "associationTypeId": 0
                    }
                ],
                "to": {
                    "id": "string"
                }
                }
            ],
            "objectWriteTraceId": "string",
            "properties": {
                "property_date": "1572480000000",
                "property_radio": "option_1",
                "property_number": "17",
                "property_string": "value",
                "property_checkbox": "false",
                "property_dropdown": "choice_b",
                "property_multiple_checkboxes": "chocolate;strawberry"
            }
            }
        ]
    });

    // Store the id of the created batch for use in other testcases
    testBatchId = response.results[0].id;
    io:println("testBatchId: ", testBatchId);
}

@test:Config {
    dependsOn: [testCreateBatchEp],
    enable: isLiveServer
}
public function testArchiveBatchEp() returns error? {
    http:Response response = check hubspotClient->/batch/archive.post({
        "inputs": [
            {
            "id": testBatchId
            }
        ]
    });

    // Check if the response status is 204
    test:assertTrue(response.statusCode == 204);
}

@test:Config {
    dependsOn: [testCreateBatchEp],
    enable: isLiveServer
}
public function testReadBatchEp() returns error? {
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors response = check hubspotClient->/batch/read.post({
        "propertiesWithHistory": [
            "string"
        ],
        "idProperty": "string",
        "inputs": [
            {
            "id": testBatchId
            }
        ],
        "properties": [
            "string"
        ]
    });

    // Check if the response contains the batch id
    test:assertEquals(response.results[0].id, testBatchId);
}

@test:Config {
    dependsOn: [testCreateBatchEp],
    enable: isLiveServer
}

    public function testUpdateBatchEp() returns error? {
    // Update batch properties
    _ = check hubspotClient->/batch/update.post({
        "inputs": [
            {
            "id": testBatchId,
            "properties": {
                "additionalProp1": "updated_string",
                "additionalProp2": "updated_string",
                "additionalProp3": "updated_string"
            }
            }
        ]
    });

    // Retrieve the batch and check if the properties are updated
    BatchResponseSimplePublicObject|BatchResponseSimplePublicObjectWithErrors updatedBatch = check hubspotClient->/batch/read.post({
        "propertiesWithHistory": [
            "string"
        ],
        "idProperty": "string",
        "inputs": [
            {
            "id": testBatchId
            }
        ],
        "properties": [
            "string"
        ]
    });
    
    test:assertEquals(updatedBatch.results[0].properties, {
        "additionalProp1": "updated_string",
        "additionalProp2": "updated_string",
        "additionalProp3": "updated_string"
    });
}

@test:Config {
    dependsOn: [testCreateBatchEp],
    enable: isLiveServer
}

public function testSearchEmailsEp() returns error? {
    // Search for emails
    CollectionResponseWithTotalSimplePublicObjectForwardPaging response = check hubspotClient->/search.post({
        "query": "string",
        "limit": 0,
        "after": "string",
        "sorts": [
            "string"
        ],
        "properties": [
            "string"
        ],
        "filterGroups": [
            {
            "filters": [
                {
                "highValue": "string",
                "propertyName": "string",
                "values": [
                    "string"
                ],
                "value": "string",
                "operator": "EQ"
                }
            ]
            }
        ]
    });

    // Check if the response contains emails
    test:assertTrue(response.results.length() > 0);
}
