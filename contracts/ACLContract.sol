// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/AccessControlEnumerable.sol";
import "openzeppelin-solidity/contracts/access/Ownable.sol";

// contract lưu role của người dùng

contract ACLContract is Ownable, AccessControlEnumerable {
    bytes32 public constant DOCTOR_ROLE = keccak256("DOCTOR_ROLE");
    bytes32 public constant NURSE_ROLE = keccak256("NURSE_ROLE");

    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    function grantDoctorRole(address _user) public onlyOwner {
        grantRole(DOCTOR_ROLE, _user);
    }

    function grantNurseRole(address _user) public onlyOwner {
        grantRole(NURSE_ROLE, _user);
    }

    function hasDoctorRole(address _user) public view returns (bool) {
        return hasRole(DOCTOR_ROLE, _user);
    }

    function hasDoctorOrNurseRole(address _user) public view returns (bool) {
        return hasRole(DOCTOR_ROLE, _user) || hasRole(NURSE_ROLE, _user);
    }
}
