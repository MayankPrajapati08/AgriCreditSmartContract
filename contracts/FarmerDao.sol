// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract FarmerContract {
    struct Farmer {
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
    
    mapping(address => Farmer) private farmers;
    mapping(address => bool) private viewers;
    
    constructor(address _owner) {
        owner = _owner;
        viewers[_owner] = true;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the GTIDS admin can perform this action.");
        _;
    }
    
    modifier onlyViewers() {
        require(viewers[msg.sender], "Only authorized viewers can access this information.");
        _;
    }
    
    function addFarmer(address _address, string memory _name, uint256 _age, string memory _Address, string memory _phoneNumber, string memory _bankDetails, string memory _kyc, string memory _plotNo, string memory _village, string memory _tehsil, string memory _block, string memory _district) public onlyOwner {
        Farmer memory newFarmer = Farmer(_name, _age, _Address, _phoneNumber, _bankDetails, _kyc, _plotNo, _village, _tehsil, _block, _district);
        farmers[_address] = newFarmer;
    }
    
    function addViewer(address _address) public onlyOwner {
        viewers[_address] = true;
    }
    
    function removeViewer(address _address) public onlyOwner {
        viewers[_address] = false;
    }
    
    function getFarmer(address _address) public view onlyViewers returns (Farmer memory) {
        return farmers[_address];
    }
}