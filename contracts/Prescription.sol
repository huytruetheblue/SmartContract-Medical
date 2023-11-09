// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Đơn thuốc của bệnh nhân

contract Prescription is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct Prescriptions {
        string[] medicalName;
        string[] dosage;
    }

    mapping(address => Prescriptions[]) private prescription;

    function addPrescription(
        address patient,
        string[] memory _medicalName,
        string[] memory _dosage
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Prescription"
        );
        require(_medicalName.length == _dosage.length, "Invalid input");

        Prescriptions memory newPrescription = Prescriptions({
            medicalName: _medicalName,
            dosage: _dosage
        });

        prescription[patient].push(newPrescription);
    }

    function getPrescription(
        address _patientAddress,
        uint256 _index
    ) public view returns (Prescriptions memory) {
        return prescription[_patientAddress][_index];
    }
}
