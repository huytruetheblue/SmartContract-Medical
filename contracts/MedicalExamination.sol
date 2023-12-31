// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Lịch sử Khám bệnh
contract MedicalExaminations is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct MedicalExamination {
        string sympton;
        string diagnostic;
        string[] medicalName;
        string[] medicalDosage;
        uint256 timestamp;
        address sender;
    }

    mapping(address => MedicalExamination[]) private medicalExaminations;

    function addMedicalExamination(
        address patient,
        string memory _sympton,
        string memory _diagnostic,
        string[] memory _medicalName,
        string[] memory _dosage
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Prescription"
        );
        MedicalExamination memory newRecord = MedicalExamination({
            sympton: _sympton,
            diagnostic: _diagnostic,
            medicalName: _medicalName,
            medicalDosage: _dosage,
            timestamp: block.timestamp,
            sender: _msgSender()
        });
        medicalExaminations[patient].push(newRecord);
    }

    function getAllMedicalExaminations(
        address _patientAddress
    ) public view returns (MedicalExamination[] memory) {
        return medicalExaminations[_patientAddress];
    }

    function getMedicalExamination(
        address _patientAddress,
        uint256 _index
    ) public view returns (MedicalExamination memory) {
        return medicalExaminations[_patientAddress][_index];
    }
}
