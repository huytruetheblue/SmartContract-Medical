// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/AccessControl.sol";

// contract lưu role của người dùng

contract ACLContract {
    bytes32 public constant DOCTOR_ROLE = keccak256("DOCTOR_ROLE");
    bytes32 public constant NURSE_ROLE = keccak256("NURSE_ROLE");
    AccessControl private _acl;

    constructor() {
        _acl = new AccessControl();
    }

    function grantDoctorRole(address _user) public {
        _acl.grantRole(DOCTOR_ROLE, _user);
    }

    function grantNurseRole(address _user) public {
        _acl.grantRole(NURSE_ROLE, _user);
    }

    function hasDoctorRole(address _user) public view returns (bool) {
        return _acl.hasRole(DOCTOR_ROLE, _user);
    }

    function hasDoctorOrNurseRole(address _user) public view returns (bool) {
        return
            _acl.hasRole(DOCTOR_ROLE, _user) || _acl.hasRole(NURSE_ROLE, _user);
    }
}
