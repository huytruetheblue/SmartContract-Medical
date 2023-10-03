import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract } from "@ethersproject/contracts";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import * as chai from "chai";

const chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

describe("Nurse", function () {
  let owner: SignerWithAddress,
    doctor: SignerWithAddress,
    patient: SignerWithAddress;

  let aclContract;

  this.beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, doctor, patient] = await ethers.getSigners();

    aclContract = await ethers.deployContract("ACLContract", owner);
  });
});
