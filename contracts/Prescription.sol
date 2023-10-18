// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Đơn thuốc của bệnh nhân

contract Precription is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct Precriptions {
        string[] medicalName;
        string[] amount;
        uint256 timestamp;
    }

    mapping(address => Precriptions[]) public precription;

    function addPrecription(
        address patient,
        string[] memory _medicalName,
        string[] memory _amount
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Precription"
        );
        require(_medicalName.length == _amount.length, "Invalid input");

        Precriptions memory newPrecription = Precriptions({
            medicalName: _medicalName,
            amount: _amount,
            timestamp: block.timestamp
        });

        precription[patient].push(newPrecription);
    }

    function getPrecription(
        address _patientAddress
    ) public view returns (Precriptions[] memory) {
        return precription[_patientAddress];
    }
}
