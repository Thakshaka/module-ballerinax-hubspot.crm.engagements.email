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

service / on new http:Listener(9090) {
    resource function post .(@http:Payload SimplePublicObjectInputForCreate payload) returns SimplePublicObject|error {
        SimplePublicObject response = {
            createdAt: "2025-02-17T06:17:42.829Z",
            archived: false,
            id: "77033339604",
            properties:
            {
                "hs_all_owner_ids": "77405866",
                "hs_body_preview": "Thanks for your interest let's find a time to talk",
                "hs_body_preview_html": "Thanks for your interest let's find a time to talk",
                "hs_body_preview_is_truncated": "false",
                "hs_createdate": "2025-02-17T06:17:42.829Z",
                "hs_email_attached_video_opened": "false",
                "hs_email_attached_video_watched": "false",
                "hs_email_click_rate": "0",
                "hs_email_direction": "EMAIL",
                "hs_email_from_email": "from@domain.com",
                "hs_email_from_firstname": "FromFirst",
                "hs_email_from_lastname": "FromLast",
                "hs_email_headers": "{ \"from\": { \"email\": \"from@domain.com\", \"firstName\": \"FromFirst\", \"lastName\": \"FromLast\" }, \"to\": [ { \"email\": \"to@test.com\", \"firstName\": \"ToFirst\", \"lastName\": \"ToLast\" } ], \"cc\": [], \"bcc\": [], \"sender\": { \"email\": \"sender@domain.com\", \"firstName\": \"SenderFirst\", \"lastName\": \"SenderLast\" } }",
                "hs_email_open_rate": "0",
                "hs_email_reply_rate": "0",
                "hs_email_sender_email": "sender@domain.com",
                "hs_email_sender_firstname": "SenderFirst",
                "hs_email_sender_lastname": "SenderLast",
                "hs_email_status": "SENT",
                "hs_email_subject": "Let's talk about Ballerina",
                "hs_email_text": "Thanks for your interest let's find a time to talk",
                "hs_email_to_email": "ToFirst+ToLast<to@test.com>",
                "hs_email_to_firstname": "ToFirst",
                "hs_email_to_lastname": "ToLast",
                "hs_lastmodifieddate": "2025-02-17T06:17:42.829Z",
                "hs_object_id": "77033339604",
                "hs_object_source": "INTEGRATION",
                "hs_object_source_id": "8151242",
                "hs_object_source_label": "INTEGRATION",
                "hs_timestamp": "2025-10-30T03:30:17.883Z",
                "hs_user_ids_of_all_owners": "77405866",
                "hubspot_owner_assigneddate": "2025-02-17T06:17:42.829Z",
                "hubspot_owner_id": "77405866"
            },
            updatedAt: "2025-02-17T06:17:42.829Z"
        };
        return response;
    }

    resource function get .() returns CollectionResponseSimplePublicObjectWithAssociationsForwardPaging|error {
        CollectionResponseSimplePublicObjectWithAssociationsForwardPaging response = {"paging": {"next": {"link": "https://api.hubapi.com/crm/v3/objects/emails/?archived=false&limit=10&after=77060812526", "after": "77060812526"}}, "results": [{"createdAt": "2025-02-14T06:43:02.485Z", "archived": false, "id": "76600938205", "properties": {"hs_createdate": "2025-02-14T06:43:02.485Z", "hs_lastmodifieddate": "2025-02-14T06:43:02.683Z", "hs_object_id": "76600938205"}, "updatedAt": "2025-02-14T06:43:02.683Z"}, {"createdAt": "2025-02-14T06:44:41.697Z", "archived": false, "id": "76600939197", "properties": {"hs_createdate": "2025-02-14T06:44:41.697Z", "hs_lastmodifieddate": "2025-02-14T06:44:41.915Z", "hs_object_id": "76600939197"}, "updatedAt": "2025-02-14T06:44:41.915Z"}, {"createdAt": "2025-02-17T06:06:48.949Z", "archived": false, "id": "76926705348", "properties": {"hs_createdate": "2025-02-17T06:06:48.949Z", "hs_lastmodifieddate": "2025-02-17T06:06:49.156Z", "hs_object_id": "76926705348"}, "updatedAt": "2025-02-17T06:06:49.156Z"}, {"createdAt": "2025-02-17T09:31:01.197Z", "archived": false, "id": "76926788316", "properties": {"hs_createdate": "2025-02-17T09:31:01.197Z", "hs_lastmodifieddate": "2025-02-17T09:31:01.424Z", "hs_object_id": "76926788316"}, "updatedAt": "2025-02-17T09:31:01.424Z"}, {"createdAt": "2025-02-17T06:17:42.829Z", "archived": false, "id": "77033339604", "properties": {"hs_createdate": "2025-02-17T06:17:42.829Z", "hs_lastmodifieddate": "2025-02-17T06:17:42.980Z", "hs_object_id": "77033339604"}, "updatedAt": "2025-02-17T06:17:42.980Z"}, {"createdAt": "2025-02-17T09:14:52.108Z", "archived": false, "id": "77033409238", "properties": {"hs_createdate": "2025-02-17T09:14:52.108Z", "hs_lastmodifieddate": "2025-02-17T09:14:52.286Z", "hs_object_id": "77033409238"}, "updatedAt": "2025-02-17T09:14:52.286Z"}, {"createdAt": "2025-02-17T08:00:07.168Z", "archived": false, "id": "77033524940", "properties": {"hs_createdate": "2025-02-17T08:00:07.168Z", "hs_lastmodifieddate": "2025-02-17T08:00:07.318Z", "hs_object_id": "77033524940"}, "updatedAt": "2025-02-17T08:00:07.318Z"}, {"createdAt": "2025-02-17T09:32:58.962Z", "archived": false, "id": "77033563861", "properties": {"hs_createdate": "2025-02-17T09:32:58.962Z", "hs_lastmodifieddate": "2025-02-17T09:32:59.258Z", "hs_object_id": "77033563861"}, "updatedAt": "2025-02-17T09:32:59.258Z"}, {"createdAt": "2025-02-17T08:42:42.243Z", "archived": false, "id": "77033638613", "properties": {"hs_createdate": "2025-02-17T08:42:42.243Z", "hs_lastmodifieddate": "2025-02-17T08:42:42.494Z", "hs_object_id": "77033638613"}, "updatedAt": "2025-02-17T08:42:42.494Z"}, {"createdAt": "2025-02-17T06:10:30.247Z", "archived": false, "id": "77060812525", "properties": {"hs_createdate": "2025-02-17T06:10:30.247Z", "hs_lastmodifieddate": "2025-02-17T06:10:30.440Z", "hs_object_id": "77060812525"}, "updatedAt": "2025-02-17T06:10:30.440Z"}]};
        return response;
    }

    resource function get [string id]() returns SimplePublicObjectWithAssociations|error {
        SimplePublicObjectWithAssociations response = {
            createdAt: "2025-02-14T06:43:02.485Z",
            archived: false,
            id: "76600938205",
            properties: {
                "hs_createdate": "2025-02-14T06:43:02.485Z",
                "hs_email_subject": "Let's talk about Ballerina",
                "hs_lastmodifieddate": "2025-02-14T06:43:02.683Z",
                "hs_object_id": "76600938205"
            },
            updatedAt: "2025-02-14T06:43:02.683Z"
        };
        return response;
    }

    resource function patch [string id](@http:Payload SimplePublicObjectInput payload) returns SimplePublicObject|error {
        SimplePublicObject response = {
            createdAt: "2025-02-18T09:07:37.230Z",
            archived: false,
            id: "77278710483",
            properties: {
                "hs_all_owner_ids": "77405866",
                "hs_createdate": "2025-02-18T09:07:37.230Z",
                "hs_email_subject": "Let's talk about Ballerina Language",
                "hs_lastmodifieddate": "2025-02-18T09:07:38.656Z",
                "hs_object_id": "77278710483",
                "hs_object_source": "INTEGRATION",
                "hs_object_source_id": "8151242",
                "hs_object_source_label": "INTEGRATION",
                "hs_us_object_id": "77278710483",
                "hs_user_ids_of_all_owners": "77405866",
                "hubspot_owner_assigneddate": "2025-02-18T09:07:37.230Z",
                "hubspot_owner_id": "77405866"
            },
            "updatedAt": "2025-02-18T09:07:38.656Z"
        };
        return response;
    }

    resource function delete [string id](http:Request request) returns http:Response|error {
        http:Response response = new;
        response.statusCode = http:STATUS_NO_CONTENT;
        return response;
    }

    resource function post batch/create(BatchInputSimplePublicObjectInputForCreate payload) returns BatchResponseSimplePublicObject|error {
        BatchResponseSimplePublicObject response = {
            completedAt: "2025-02-18T09:49:46.462Z",
            startedAt: "2025-02-18T09:49:46.214Z",
            results: [
                {
                    createdAt: "2025-02-18T09:49:46.220Z",
                    archived: false,
                    id: "77606932181",
                    properties: {
                        "hs_body_preview_is_truncated": "false",
                        "hs_createdate": "2025-02-18T09:49:46.220Z",
                        "hs_email_attached_video_opened": "false",
                        "hs_email_attached_video_watched": "false",
                        "hs_email_click_rate": "0",
                        "hs_email_direction": "EMAIL",
                        "hs_email_open_rate": "0",
                        "hs_email_reply_rate": "0",
                        "hs_lastmodifieddate": "2025-02-18T09:49:46.220Z",
                        "hs_object_id": "77606932181",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8151242",
                        "hs_object_source_label": "INTEGRATION",
                        "hs_timestamp": "2025-02-18T09:49:46.220Z"
                    },
                    updatedAt: "2025-02-18T09:49:46.220Z"
                }
            ],
            status: "COMPLETE"
        };
        return response;
    }

    resource function post batch/read(BatchReadInputSimplePublicObjectId payload) returns BatchResponseSimplePublicObject|error {
        BatchResponseSimplePublicObject response = {
            completedAt: "2025-02-18T11:08:35.071Z",
            startedAt: "2025-02-18T11:08:35.061Z",
            results: [
                {
                    createdAt: "2025-02-18T11:08:34.513Z",
                    archived: false,
                    propertiesWithHistory: {
                        "hs_email_direction": [
                            {
                                "sourceId": "8151242",
                                "sourceType": "INTEGRATION",
                                "value": "EMAIL",
                                "timestamp": "2025-02-18T11:08:34.513Z"
                            }
                        ]
                    },
                    id: "77650314959",
                    properties: {
                        "hs_createdate": "2025-02-18T11:08:34.513Z",
                        "hs_email_direction": "EMAIL",
                        "hs_lastmodifieddate": "2025-02-18T11:08:34.946Z",
                        "hs_object_id": "77650314959"
                    },
                    updatedAt: "2025-02-18T11:08:34.946Z"
                }
            ],
            status: "COMPLETE"
        };
        return response;
    }

    resource function post batch/update(BatchInputSimplePublicObjectBatchInput payload) returns BatchResponseSimplePublicObject|error {
        BatchResponseSimplePublicObject response = {
            completedAt: "2025-02-18T11:19:40.826Z",
            startedAt: "2025-02-18T11:19:40.759Z",
            results: [
                {
                    createdAt: "2025-02-18T11:19:39.896Z",
                    archived: false,
                    id: "77608771264",
                    properties: {
                        "hs_createdate": "2025-02-18T11:19:39.896Z",
                        "hs_email_direction": "FORWARDED_EMAIL",
                        "hs_lastmodifieddate": "2025-02-18T11:19:40.768Z",
                        "hs_object_id": "77608771264",
                        "hs_object_source": "INTEGRATION",
                        "hs_object_source_id": "8151242",
                        "hs_object_source_label": "INTEGRATION"
                    },
                    updatedAt: "2025-02-18T11:19:40.768Z"
                }
            ],
            status: "COMPLETE"
        };
        return response;
    }

    resource function post batch/archive(@http:Payload json payload) returns http:Response|error {
        http:Response response = new;
        if payload.inputs is json[] && payload.inputs != null {
            response.statusCode = http:STATUS_NO_CONTENT;
        } else {
            response.statusCode = http:STATUS_BAD_REQUEST;
        }
        return response;
    }

    resource function post search(PublicObjectSearchRequest payload) returns CollectionResponseWithTotalSimplePublicObjectForwardPaging|error {
        CollectionResponseWithTotalSimplePublicObjectForwardPaging response = {
            total: 17,
            paging: {
                next: {
                    after: "10"
                }
            },
            results: [
                {
                    createdAt: "2025-02-14T06:44:41.697Z",
                    archived: false,
                    id: "76600939197",
                    properties: {
                        "hs_createdate": "2025-02-14T06:44:41.697Z",
                        "hs_lastmodifieddate": "2025-02-14T06:44:41.915Z",
                        "hs_object_id": "76600939197"
                    },
                    updatedAt: "2025-02-14T06:44:41.915Z"
                },
                {
                    createdAt: "2025-02-17T06:03:07.041Z",
                    archived: false,
                    id: "77064575719",
                    properties: {
                        "hs_createdate": "2025-02-17T06:03:07.041Z",
                        "hs_lastmodifieddate": "2025-02-17T06:03:07.282Z",
                        "hs_object_id": "77064575719"
                    },
                    updatedAt: "2025-02-17T06:03:07.282Z"
                },
                {
                    createdAt: "2025-02-17T06:06:48.949Z",
                    archived: false,
                    id: "76926705348",
                    properties: {
                        "hs_createdate": "2025-02-17T06:06:48.949Z",
                        "hs_lastmodifieddate": "2025-02-17T06:06:49.156Z",
                        "hs_object_id": "76926705348"
                    },
                    updatedAt: "2025-02-17T06:06:49.156Z"
                },
                {
                    createdAt: "2025-02-17T06:10:30.247Z",
                    archived: false,
                    id: "77060812525",
                    properties: {
                        "hs_createdate": "2025-02-17T06:10:30.247Z",
                        "hs_lastmodifieddate": "2025-02-17T06:10:30.440Z",
                        "hs_object_id": "77060812525"
                    },
                    updatedAt: "2025-02-17T06:10:30.440Z"
                },
                {
                    createdAt: "2025-02-17T06:17:42.829Z",
                    archived: false,
                    id: "77033339604",
                    properties: {
                        "hs_createdate": "2025-02-17T06:17:42.829Z",
                        "hs_lastmodifieddate": "2025-02-17T06:17:42.980Z",
                        "hs_object_id": "77033339604"
                    },
                    updatedAt: "2025-02-17T06:17:42.980Z"
                },
                {
                    createdAt: "2025-02-17T07:55:45.515Z",
                    archived: false,
                    id: "77065219770",
                    properties: {
                        "hs_createdate": "2025-02-17T07:55:45.515Z",
                        "hs_lastmodifieddate": "2025-02-17T07:55:45.804Z",
                        "hs_object_id": "77065219770"
                    },
                    updatedAt: "2025-02-17T07:55:45.804Z"
                },
                {
                    createdAt: "2025-02-17T08:00:07.168Z",
                    archived: false,
                    id: "77033524940",
                    properties: {
                        "hs_createdate": "2025-02-17T08:00:07.168Z",
                        "hs_lastmodifieddate": "2025-02-17T08:00:07.318Z",
                        "hs_object_id": "77033524940"
                    },
                    updatedAt: "2025-02-17T08:00:07.318Z"
                },
                {
                    createdAt: "2025-02-17T08:08:52.926Z",
                    archived: false,
                    id: "77067073218",
                    properties: {
                        "hs_createdate": "2025-02-17T08:08:52.926Z",
                        "hs_lastmodifieddate": "2025-02-17T08:08:53.160Z",
                        "hs_object_id": "77067073218"
                    },
                    updatedAt: "2025-02-17T08:08:53.160Z"
                },
                {
                    createdAt: "2025-02-17T08:29:00.593Z",
                    archived: false,
                    id: "77068892865",
                    properties: {
                        "hs_createdate": "2025-02-17T08:29:00.593Z",
                        "hs_lastmodifieddate": "2025-02-17T08:29:00.795Z",
                        "hs_object_id": "77068892865"
                    },
                    updatedAt: "2025-02-17T08:29:00.795Z"
                },
                {
                    createdAt: "2025-02-17T08:42:42.243Z",
                    archived: false,
                    id: "77033638613",
                    properties: {
                        "hs_createdate": "2025-02-17T08:42:42.243Z",
                        "hs_lastmodifieddate": "2025-02-17T08:42:42.494Z",
                        "hs_object_id": "77033638613"
                    },
                    updatedAt: "2025-02-17T08:42:42.494Z"
                }
            ]
        };
        return response;
    }
}
