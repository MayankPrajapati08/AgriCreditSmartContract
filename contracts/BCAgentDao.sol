// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BCAgentContract {
    struct BCAgent {
        string name;
        uint256 age;
        string Address;
        string phoneNumber;
        string bankDetails;
        string kyc;
        string plotNo;
        string village;
        string tehsil;
        string block;
        string district;
    }
    
    address private owner;
    mapping(address => BCAgent) private agents;
    mapping(address => bool) private viewers;
    
    constructor(address _owner) {
        owner = _owner;
        viewers[owner] = true;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the GTIDS admin can perform this action.");
        _;
    }
    
    modifier onlyViewers() {
        require(viewers[msg.sender], "Only authorized viewers can access this information.");
        _;
    }
    
    function addAgent(address _address, string memory _name, uint256 _age, string memory _Address, string memory _phoneNumber, string memory _bankDetails, string memory _kyc, string memory _plotNo, string memory _village, string memory _tehsil, string memory _block, string memory _district) public onlyOwner {
        BCAgent storage newAgent = agents[_address];
        newAgent.name = _name;
        newAgent.age = _age;
        newAgent.Address = _Address;
        newAgent.phoneNumber = _phoneNumber;
        newAgent.bankDetails = _bankDetails;
        newAgent.kyc = _kyc;
        newAgent.plotNo = _plotNo;
        newAgent.village = _village;
        newAgent.tehsil = _tehsil;
        newAgent.block = _block;
        newAgent.district = _district;
    }
    
    function addViewer(address _address) public onlyOwner {
        viewers[_address] = true;
    }
    
    function removeViewer(address _address) public onlyOwner {
        viewers[_address] = false;
    }
    
    function getAgent(address _address) public view onlyViewers returns (BCAgent memory) {
        return agents[_address];
    }
}