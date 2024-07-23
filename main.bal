import ballerina/http;
import ballerina/lang.'decimal as decimal0;
import ballerina/lang.'int as int0;
import ballerina/lang.'string as string0;
import ballerinax/sap.jco;
import ballerina/io;

configurable jco:DestinationConfig destinationConfigs = ?;


isolated function addItem(APIData request) returns APIData|error? {
    ImportParams importParams = check transform(request);
    jco:Client sapClient = check new (destinationConfigs);
    io:println(importParams);
    return request;
    ExportParams? exportParams = check sapClient->execute("Z_FCA_BY_PETRORTL", importParams);
    if (exportParams is ExportParams) {
        return request;
    } else {
        return error("Error occurred while adding the item");
    }
}

service /reliance on new http:Listener(8080) {
    isolated resource function post .(@http:Payload APIData request) returns APIData|error? {
        return check addItem(request);
    }
}

isolated function transform(APIData apiData) returns ImportParams|error => {
    HSN_SAC: apiData.petroRetailData.charFieldlength,
    DESCRIPTION: apiData.petroRetailData.comment,
    BUKRS: apiData.petroRetailData.companyCode,
    KOSTL: apiData.petroRetailData.costCenter,
    BLDAT: {
        year: check int0:fromString(string0:substring(apiData.petroRetailData.documentDate, 6, 9)),
        month: check int0:fromString(string0:substring(apiData.petroRetailData.documentDate, 3, 4)),
        day: check int0:fromString(string0:substring(apiData.petroRetailData.documentDate, 0, 1))
    },
    GJAHR: check int0:fromString(apiData.petroRetailData.fiscalYear),
    HKONT: apiData.petroRetailData.generalLedgerAccount,
    GST_USG: apiData.petroRetailData.gstUsage,
    BELNR: apiData.petroRetailData.itemNumAssignment,
    BUZEI: check int0:fromString(apiData.petroRetailData.lineItem),
    DMBTR: check decimal0:fromString(apiData.petroRetailData.localCurrencyAmt),
    PARTNER: apiData.petroRetailData.partner,
    LIFNR: apiData.petroRetailData.vendorCreditorAccount,
    BUDAT: {
        year: check int0:fromString(string0:substring(apiData.petroRetailData.postingDate, 6, 9)),
        month: check int0:fromString(string0:substring(apiData.petroRetailData.postingDate, 3, 4)),
        day: check int0:fromString(string0:substring(apiData.petroRetailData.postingDate, 0, 1))
    }
};
