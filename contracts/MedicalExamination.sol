// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Lịch sử Khám bệnh
contract MedicalExaminations {
    struct MedicalExamination {
        string sympton;
        string diagnostic;
        address medicalRecord;
        uint256 timestamp;
    }

    mapping(address => MedicalExamination[]) private medicalExaminations;
    event MediCalExaminationAdded(
        address indexed examinationAddress,
        string sympton,
        string diagnostic,
        address medicalRecord,
        uint256 timestamp
    );

    function addMedicalExamination(
        string memory _sympton,
        string memory _diagnostic,
        address _medicalRecord
    ) public {
        MedicalExamination memory newRecord = MedicalExamination(
            _sympton,
            _diagnostic,
            _medicalRecord,
            block.timestamp
        );
        medicalExaminations[msg.sender].push(newRecord);
        emit MediCalExaminationAdded(
            msg.sender,
            _sympton,
            _diagnostic,
            _medicalRecord,
            block.timestamp
        );
    }

    function getMedicalRecords(
        address _patientAddress
    ) public view returns (MedicalExamination[] memory) {
        return medicalExaminations[_patientAddress];
    }
}
