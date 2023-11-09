// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Bệnh án của bệnh nhân

contract MedicalRecords is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct MedicalRecord {
        string patientName;
        string patientAddress;
        string patientBirthday;
        bool patientGender;
        string patientNumber;
        uint256 timestamp;
    }

    mapping(address => MedicalRecord) private medicalRecords;

    event MedicalRecordAdded(
        address indexed patient,
        string patientName,
        string patientAddress,
        string patientBirthday,
        bool patientGender,
        string patientNumber,
        uint256 timestamp
    );

    function addMedicalRecord(
        address patient,
        string memory _patientName,
        string memory _patientAddress,
        string memory _patientBirthday,
        bool _patientGender,
        string memory _patientNumber
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can create new MedicalRecord"
        );
        MedicalRecord memory newRecord = MedicalRecord(
            _patientName,
            _patientAddress,
            _patientBirthday,
            _patientGender,
            _patientNumber,
            block.timestamp
        );
        medicalRecords[patient] = newRecord;
        emit MedicalRecordAdded(
            msg.sender,
            _patientName,
            _patientAddress,
            _patientBirthday,
            _patientGender,
            _patientNumber,
            block.timestamp
        );
    }

    function getMedicalRecords(
        address _patientAddress
    ) public view returns (MedicalRecord memory) {
        return medicalRecords[_patientAddress];
    }
}
