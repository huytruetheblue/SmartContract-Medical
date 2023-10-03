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
    }

    Test[] public testHistory;

    function addTest(
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
            timestamp: block.timestamp
        });

        testHistory.push(newTest);
    }

    function getTestHistory(
        uint256 index
    ) public view returns (string memory, string memory, uint256) {
        require(
            owner() == _msgSender() ||
                private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only nurses and doctors can read each other's test history"
        );
        require(index < testHistory.length, "Invalid index");

        Test memory test = testHistory[index];
        return (test.testName, test.testResult, test.timestamp);
    }
}
