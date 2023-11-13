// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Lịch sử tiêm chủng

contract VaccinationHistory is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct Vaccination {
        string vacName;
        string vacType;
        uint256 timestamp;
        address sender;
    }

    mapping(address => Vaccination[]) public vaccHistory;

    function addVaccin(
        address patient,
        string memory _vacType,
        string memory _vacName
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Vaccination"
        );
        Vaccination memory newVacc = Vaccination({
            vacType: _vacType,
            vacName: _vacName,
            timestamp: block.timestamp,
            sender: _msgSender()
        });

        vaccHistory[patient].push(newVacc);
    }

    function getVaccinHistory(
        address _patientAddress
    ) public view returns (Vaccination[] memory) {
        return vaccHistory[_patientAddress];
    }
}
