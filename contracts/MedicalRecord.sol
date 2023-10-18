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
        string date;
        uint256 timestamp;
    }

    mapping(address => MedicalRecord[]) private medicalRecords;

    event MedicalRecordAdded(
        address indexed patientAddress,
        string patientName,
        string date
    );

    function addMedicalRecord(
        string memory _patientName,
        string memory _date
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new MedicalRecord"
        );
        MedicalRecord memory newRecord = MedicalRecord(
            _patientName,
            _date,
            block.timestamp
        );
        medicalRecords[msg.sender].push(newRecord);
        emit MedicalRecordAdded(msg.sender, _patientName, _date);
    }

    function getMedicalRecords(
        address _patientAddress
    ) public view returns (MedicalRecord[] memory) {
        return medicalRecords[_patientAddress];
    }
}
