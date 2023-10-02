// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Bệnh án của bệnh nhân

contract MedicalRecords {
    struct MedicalRecord {
        string patientName;
        string diagnosis;
        uint256 timestamp;
    }

    mapping(address => MedicalRecord[]) private medicalRecords;

    event MedicalRecordAdded(
        address indexed patientAddress,
        string patientName,
        string diagnosis,
        uint256 timestamp
    );

    function addMedicalRecord(
        string memory _patientName,
        string memory _diagnosis
    ) public {
        MedicalRecord memory newRecord = MedicalRecord(
            _patientName,
            _diagnosis,
            block.timestamp
        );
        medicalRecords[msg.sender].push(newRecord);
        emit MedicalRecordAdded(
            msg.sender,
            _patientName,
            _diagnosis,
            block.timestamp
        );
    }

    function getMedicalRecords(
        address _patientAddress
    ) public view returns (MedicalRecord[] memory) {
        return medicalRecords[_patientAddress];
    }
}
