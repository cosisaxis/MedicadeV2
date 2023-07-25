// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicalRecordsContract {
    // Structure to represent medical records
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

    // Array to store all medical records
    MedicalRecord[] public medicalRecords;

    // Mapping to keep track of patient-specific records
    mapping(address => uint256[]) private patientRecords;

    // Event to log new medical records
    event MedicalRecordAdded(uint256 indexed recordId, address indexed patientAddress);

    // Modifier to ensure only authorized personnel can add medical records
    modifier onlyAuthorizedPersonnel() {
        // Add your access control logic here, e.g., check for roles, permissions, etc.
        _;
    }

    // Function to add a new medical record
    function addMedicalRecord(
        string memory _patientName,
        string memory _diagnosis,
        string memory _prescription,
        string memory _gender,
        uint256 _age
    ) public onlyAuthorizedPersonnel {
        uint256 recordId = medicalRecords.length;

        // Create a new MedicalRecord struct
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

        // Store the record in the array and map it to the patient
        medicalRecords.push(newRecord);
        patientRecords[msg.sender].push(recordId);

        // Emit an event to log the addition of a new medical record
        emit MedicalRecordAdded(recordId, msg.sender);
    }

    // Function to retrieve all medical records of a patient
    function getPatientMedicalRecords() public view returns (MedicalRecord[] memory) {
        uint256[] memory patientRecordIds = patientRecords[msg.sender];
        MedicalRecord[] memory records = new MedicalRecord[](patientRecordIds.length);

        for (uint256 i = 0; i < patientRecordIds.length; i++) {
            records[i] = medicalRecords[patientRecordIds[i]];
        }

        return records;
    }
}
