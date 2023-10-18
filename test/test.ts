import { TestHistory } from "./../typechain-types/contracts/TestHistory";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Contract } from "@ethersproject/contracts";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import * as chai from "chai";
import { keccak256 } from "ethers/lib/utils";

const chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

describe("Test History", function () {
  let owner: SignerWithAddress,
    doctor: SignerWithAddress,
    stranger: SignerWithAddress,
    patient: SignerWithAddress;

  let aclContract: Contract;
  let testHistory: Contract;

  this.beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, doctor, stranger, patient] = await ethers.getSigners();

    const ACLContract = await ethers.getContractFactory("ACLContract", owner);
    aclContract = await ACLContract.deploy();

    const TestHistory = await ethers.getContractFactory("TestHistory", owner);
    testHistory = await TestHistory.deploy(aclContract.address);
    let DOCTOR_ROLE = keccak256(Buffer.from("DOCTOR_ROLE")).toString();
    await aclContract.grantRole(DOCTOR_ROLE, doctor.address);
  });

  // Happy Path

  it("Doctor can add new Test", async () => {
    await expect(
      testHistory.connect(doctor).addTest(patient.address, "Covid", "Normal")
    );
  });

  // Unhappy Path

  it("Stranger can not add new Test", async () => {
    await expect(
      testHistory.connect(stranger).addTest(patient.address, "Covid", "Normal")
    ).revertedWith("Only Doctor or Nurse can add new Test");
  });

  it("Can not get invalid index Test", async () => {
    testHistory.connect(doctor).addTest(patient.address, "Covid", "Normal");
    await expect(testHistory.getTestHistory(patient.address, 2)).revertedWith(
      "Invalid index"
    );
  });
});

describe("Vaccination History", function () {
  let owner: SignerWithAddress,
    doctor: SignerWithAddress,
    stranger: SignerWithAddress,
    patient: SignerWithAddress;

  let aclContract: Contract;
  let vaccinationHistory: Contract;

  this.beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, doctor, stranger, patient] = await ethers.getSigners();

    const ACLContract = await ethers.getContractFactory("ACLContract", owner);
    aclContract = await ACLContract.deploy();

    const VaccinationHistory = await ethers.getContractFactory(
      "VaccinationHistory",
      owner
    );
    vaccinationHistory = await VaccinationHistory.deploy(aclContract.address);

    let DOCTOR_ROLE = keccak256(Buffer.from("DOCTOR_ROLE")).toString();
    await aclContract.grantRole(DOCTOR_ROLE, doctor.address);
  });

  // Happy Path

  it("Doctor can add new Vaccination", async () => {
    await expect(
      vaccinationHistory
        .connect(doctor)
        .addVaccin(patient.address, "Covid", "400ml")
    );
  });

  // Unhappy Path

  it("Stranger can not add new Vaccination", async () => {
    await expect(
      vaccinationHistory
        .connect(stranger)
        .addVaccin(patient.address, "Covid", "Normal")
    ).revertedWith("Only Doctor or Nurse can add new Vaccination");
  });

  it("Can not get invalid index Vaccination", async () => {
    vaccinationHistory
      .connect(doctor)
      .addVaccin(patient.address, "Covid", "Normal");
    await expect(
      vaccinationHistory.getVaccinHistory(patient.address, 2)
    ).revertedWith("Invalid index");
  });
});

describe("Diagnosis by Imageing", function () {
  let owner: SignerWithAddress,
    doctor: SignerWithAddress,
    stranger: SignerWithAddress,
    patient: SignerWithAddress;

  let aclContract: Contract;
  let diagnosisByImageing: Contract;

  this.beforeEach(async () => {
    await ethers.provider.send("hardhat_reset", []);
    [owner, doctor, stranger, patient] = await ethers.getSigners();

    const ACLContract = await ethers.getContractFactory("ACLContract", owner);
    aclContract = await ACLContract.deploy();

    const DiagnosisByImageing = await ethers.getContractFactory(
      "DiagnosisByImageing",
      owner
    );
    diagnosisByImageing = await DiagnosisByImageing.deploy(aclContract.address);

    let DOCTOR_ROLE = keccak256(Buffer.from("DOCTOR_ROLE")).toString();
    await aclContract.grantRole(DOCTOR_ROLE, doctor.address);
  });

  // Happy Path

  it("Doctor can add new Diagnosis By Imageing", async () => {
    await expect(
      diagnosisByImageing
        .connect(doctor)
        .addDiaImage(patient.address, "Covid", "400ml")
    );
  });

  // Unhappy Path

  it("Stranger can not add new Diagnosis by Imageing", async () => {
    await expect(
      diagnosisByImageing
        .connect(stranger)
        .addDiaImage(patient.address, "Covid", "Normal")
    ).revertedWith("Only Doctor or Nurse can add new Diagnosis By Imageing");
  });

  it("Can not get invalid index Diagnosis by Imageing", async () => {
    diagnosisByImageing
      .connect(doctor)
      .addDiaImage(patient.address, "Covid", "Normal");
    await expect(
      diagnosisByImageing.getDiaImageHistory(patient.address, 2)
    ).revertedWith("Invalid index");
  });
});
