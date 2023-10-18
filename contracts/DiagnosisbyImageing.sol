// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-solidity/contracts/access/Ownable.sol";
import "./ACLContract.sol";

// Chuẩn đoán bằng hình ảnh

contract DiagnosisByImageing is Ownable {
    ACLContract immutable private_acl;

    constructor(address _acl) {
        private_acl = ACLContract(_acl);
    }

    struct DiaImage {
        string diaName;
        string image;
        uint256 timestamp;
    }

    mapping(address => DiaImage[]) public diaImage;

    function addDiaImage(
        address patient,
        string memory _diaName,
        string memory _image
    ) public {
        require(
            private_acl.hasDoctorOrNurseRole(_msgSender()),
            "Only Doctor or Nurse can add new Diagnosis By Imageing"
        );
        DiaImage memory newDiaImage = DiaImage({
            diaName: _diaName,
            image: _image,
            timestamp: block.timestamp
        });

        diaImage[patient].push(newDiaImage);
    }

    function getDiaImageHistory(
        address _patientAddress
    ) public view returns (DiaImage[] memory) {
        return diaImage[_patientAddress];
    }
}
