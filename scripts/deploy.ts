import { ethers, hardhatArguments } from "hardhat";
import * as Config from "./config";

async function main() {
  await Config.initConfig();
  const network = hardhatArguments.network ? hardhatArguments.network : "dev";
  const [deployer] = await ethers.getSigners();
  console.log("deploy from address: ", deployer.address);

  // const ACLContract = await ethers.getContractFactory("ACLContract");
  // const aclContract = await ACLContract.deploy();
  // console.log("ACLContract address: ", aclContract.address);
  // Config.setConfig(network + ".ACLContract", aclContract.address);

  // const TestHistory = await ethers.getContractFactory("TestHistory");
  // const testHistory = await TestHistory.deploy(
  //   "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  // );
  // console.log("TestHistory address: ", testHistory.address);
  // Config.setConfig(network + ".TestHistory", testHistory.address);

  const VaccinationHistory = await ethers.getContractFactory(
    "VaccinationHistory"
  );
  const vaccinationHistory = await VaccinationHistory.deploy(
    "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  );
  console.log("TestHistory address: ", vaccinationHistory.address);
  Config.setConfig(network + ".VaccinationHistory", vaccinationHistory.address);
  await Config.updateConfig();

  // const Prescription = await ethers.getContractFactory("Prescription");
  // const prescription = await Prescription.deploy(
  //   "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  // );
  // console.log("Prescription address: ", prescription.address);
  // Config.setConfig(network + ".Prescription", prescription.address);
  // await Config.updateConfig();

  // const MedicalRecords = await ethers.getContractFactory("MedicalRecords");
  // const medicalRecord = await MedicalRecords.deploy(
  //   "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  // );
  // console.log("MedicalRecords address: ", medicalRecord.address);
  // Config.setConfig(network + ".MedicalRecords", medicalRecord.address);
  // await Config.updateConfig();

  // const MedicalExaminations = await ethers.getContractFactory(
  //   "MedicalExaminations"
  // );
  // const medicalExaminations = await MedicalExaminations.deploy(
  //   "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  // );
  // console.log("MedicalExaminations address: ", medicalExaminations.address);
  // Config.setConfig(
  //   network + ".MedicalExaminations",
  //   medicalExaminations.address
  // );
  // await Config.updateConfig();

  // const DiagnosisByImageing = await ethers.getContractFactory(
  //   "DiagnosisByImageing"
  // );
  // const diagnosisByImageing = await DiagnosisByImageing.deploy(
  //   "0xea4F2Ba39F10586a5AD66481fDFF0E201fD31DE9"
  // );
  // console.log("DiagnosisByImageing address: ", diagnosisByImageing.address);
  // Config.setConfig(
  //   network + ".DiagnosisByImageing",
  //   diagnosisByImageing.address
  // );
  // await Config.updateConfig();
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
