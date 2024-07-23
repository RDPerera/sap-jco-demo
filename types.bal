import ballerina/time;
type PetroRetailData record {
    string charFieldlength;
    string comment;
    string companyCode;
    string costCenter;
    string documentDate;
    string fiscalYear;
    string format;
    string generalLedgerAccount;
    string gstUsage = "";
    string itemNumAssignment;
    string lineItem = "";
    string localCurrencyAmt;
    string partner = "";
    string postingDate;
    string vendorCreditorAccount;
};

type APIData record {
    PetroRetailData petroRetailData;
};


type ImportParams record {
    string BUKRS?;
    string BELNR?;
    int GJAHR?;
    int BUZEI?;
    time:Date BLDAT?;
    time:Date BUDAT?;
    string HKONT?;
    string LIFNR?;
    string KOSTL?;
    decimal DMBTR?;
    string DESCRIPTION?;
    string HSN_SAC?;
    string GST_USG?;
    string PARTNER?;
};

type ExportParams record {
    string TYPE?;
    string ID?;
    int NUMBER?;
    string MESSAGE?;
    string LOG_NO?;
    string LOG_MSG_NO;
    string MESSAGE_V1?;
    string MESSAGE_V2?;
    string MESSAGE_V3?;
    string MESSAGE_V4?;
    string PARAMETER?;
    int ROW?;
    string FIELD?;
    string SYSTEM?;
};
