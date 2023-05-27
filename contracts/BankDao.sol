// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract BankContract {
    struct Bank {
        string bankName;
        string branch;
        string ifscCode;
        string district;
        string state;
    }
    
    address private owner;
    
    mapping(address => Bank) private banks;
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
    
    function addBank(address _address, string memory _bankName, string memory _branch, string memory _ifscCode, string memory _district, string memory _state) public onlyOwner {
        Bank memory newBank = Bank(_bankName, _branch, _ifscCode, _district, _state);
        banks[_address] = newBank;
    }
    
    function addViewer(address _address) public onlyOwner {
        viewers[_address] = true;
    }
    
    function removeViewer(address _address) public onlyOwner {
        viewers[_address] = false;
    }
    
    function getBank(address _address) public view onlyViewers returns (Bank memory) {
        return banks[_address];
    }
}