// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract WarehouseContract {
    struct Warehouse {
        string organization;
        string name;
        string Address;
        string tinNo;
        string gstinNo;
    }
    
    address private owner;
    
    mapping(address => Warehouse) private warehouses;
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
    
    function addWarehouse(address _address, string memory _organization, string memory _name, string memory _Address, string memory _tinNo, string memory _gstinNo) public onlyOwner {
        Warehouse memory newWarehouse = Warehouse(_organization, _name, _Address, _tinNo, _gstinNo);
        warehouses[_address] = newWarehouse;
    }
    
    function addViewer(address _address) public onlyOwner {
        viewers[_address] = true;
    }
    
    function removeViewer(address _address) public onlyOwner {
        viewers[_address] = false;
    }
    
    function getWarehouse(address _address) public view onlyViewers returns (Warehouse memory) {
        return warehouses[_address];
    }
}
