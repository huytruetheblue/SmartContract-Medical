// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Lịch sử xét nghiệm

contract TestHistory is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct Test {
        string testName;
        string testResult;
        uint256 timestamp;
        address sender;
    }

    mapping(address => Test[]) public testHistory;

    function addTest(
        address patient,
        string memory _testName,
        string memory _testResult
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Test"
        );
        Test memory newTest = Test({
            testName: _testName,
            testResult: _testResult,
            sender: _msgSender(),
            timestamp: block.timestamp
        });

        testHistory[patient].push(newTest);
    }

    function getTestHistory(
        address patient
    ) public view returns (Test[] memory) {
        return testHistory[patient];
    }
}
