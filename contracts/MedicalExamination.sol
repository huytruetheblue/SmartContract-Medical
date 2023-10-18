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
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Precription"
        );
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
