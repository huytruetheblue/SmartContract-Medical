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
        string vacAmount;
        uint256 timestamp;
    }

    Vaccination[] public vaccHistory;

    function addVaccin(
        string memory _vacName,
        string memory _vacAmount
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Vaccination"
        );
        Vaccination memory newVacc = Vaccination({
            vacName: _vacName,
            vacAmount: _vacAmount,
            timestamp: block.timestamp
        });

        vaccHistory.push(newVacc);
    }

    function getVaccinHistory(
        uint256 index
    ) public view returns (string memory, string memory, uint256) {
        require(
            owner() == _msgSender() ||
                private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only nurses and doctors can read each other's Vaccination history"
        );
        require(index < vaccHistory.length, "Invalid index");

        Vaccination memory vacc = vaccHistory[index];
        return (vacc.vacName, vacc.vacAmount, vacc.timestamp);
    }
}
