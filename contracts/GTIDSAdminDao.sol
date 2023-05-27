// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract GTIDSAdminContract {
    struct GTIDSAdmin {
        string name;
        uint256 age;
        string Address;
        string phoneNumber;
        string bankDetails;
        string kyc;
    }
    
    address private owner;
    
    mapping(address => GTIDSAdmin) private admins;
    mapping(address => bool) private viewers;
    
    constructor() {
        owner = msg.sender;
        viewers[msg.sender] = true;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the GTIDS admin can perform this action.");
        _;
    }
    
    modifier onlyViewers() {
        require(viewers[msg.sender], "Only authorized viewers can access this information.");
        _;
    }
    
    function addAdmin(address _address, string memory _name, uint256 _age, string memory _Address, string memory _phoneNumber, string memory _bankDetails, string memory _kyc) public onlyOwner {
        GTIDSAdmin memory newAdmin = GTIDSAdmin(_name, _age, _Address, _phoneNumber, _bankDetails, _kyc);
        admins[_address] = newAdmin;
    }
    
    function addViewer(address _address) public onlyOwner {
        viewers[_address] = true;
    }
    
    function removeViewer(address _address) public onlyOwner {
        viewers[_address] = false;
    }
    
    function getAdmin(address _address) public view onlyViewers returns (GTIDSAdmin memory) {
        return admins[_address];
    }
}