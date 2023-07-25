// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecordsContract {
    
    address private contractOwner;

    
    struct MedicalRecord {
        uint256 recordId;
        string patientName;
        string diagnosis;
        string prescription;
        string gender;
        uint256 timestamp;
        uint256 age;
        address creator;
    }

    constructor() {
        contractOwner = msg.sender;
    }

  
    MedicalRecord[] public medicalRecords;
    mapping(address => uint256[]) private patientRecords;
    event MedicalRecordAdded(uint256 indexed recordId, address indexed patientAddress);

    
    modifier onlyAuthorizedPersonnel() {
        require(msg.sender == contractOwner, "You cannot do this");
        _;
    }

    
    function addMedicalRecord( string memory _patientName, string memory _diagnosis, string memory _prescription, string memory _gender, uint256 _age) public onlyAuthorizedPersonnel {
        uint256 recordId = medicalRecords.length;
        MedicalRecord memory newRecord = MedicalRecord({
            recordId: recordId,
            patientName: _patientName,
            diagnosis: _diagnosis,
            prescription: _prescription,
            gender: _gender,
            age: _age,
            timestamp: block.timestamp,
            creator: msg.sender
        });

        
        medicalRecords.push(newRecord);
        patientRecords[msg.sender].push(recordId);
        emit MedicalRecordAdded(recordId, msg.sender);
    }

    
    function getPatientMedicalRecords() public view returns (MedicalRecord[] memory) {
        uint256[] memory patientRecordIds = patientRecords[msg.sender];
        MedicalRecord[] memory records = new MedicalRecord[](patientRecordIds.length);

        for (uint256 i = 0; i < patientRecordIds.length; i++) {
            records[i] = medicalRecords[patientRecordIds[i]];
        }
        return records;
    }
}
