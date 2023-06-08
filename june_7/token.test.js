// Right click on the script name and hit "Run" to execute
const { expect } = require("chai");
const { ethers } = require("hardhat");

// Test should have the same name as the contract they are testing
describe("Token", function () {

  // declare the variables above the tests, so that we have access to them throughout
  let token;
  let sarah = "0x85beD5928b351892cd610a554C018978BA944A95";
  let signers;

  // beforeEach is run newly before each it-block
  beforeEach(async function () {
    // signers is an array of addresses, populated with test ether
    // signers = [anAddress, anotherAddress];
    signers = await ethers.getSigners();
    // Build the contract object, using the exact name of the contract
    // for each test, we deploy a fresh version of the contract
    const Token = await ethers.getContractFactory("Token");
    token = await Token.deploy();
    await token.deployed();
  });

  // test that before any tokens have been minted, the balance returns 0
  it("test initial value", async function () {
    console.log('token deployed at:'+ token.address);
    expect((await token.balanceOf(sarah)).toNumber()).to.equal(0);
  });

  // test that the mint function correctly mints to the given address
  it("test mint", async function () {
    console.log('token deployed at:'+ token.address);
    const tx = await token.connect(signers[1]).mint(signers[1].address)
    await tx.wait();
    expect((await token.balanceOf(signers[1].address)).toNumber()).to.equal(10);
  });

  // test that the transfer deducts tokens from the tx sender
  it("test transfer leaves transfer sender with correct balance", async function () {
    console.log('token deployed at:'+ token.address);
    // this pulls two addresses out of the signers array and stores them
    // using more readable names
    let [sender, recipient] = [...signers];
    let tx = await token.connect(sender).mint(sender.address);
    await tx.wait();
    tx = await token.connect(sender).transfer(recipient.address, 5);
    await tx.wait();
    expect((await token.balanceOf(sender.address)).toNumber()).to.equal(5);
  })

})