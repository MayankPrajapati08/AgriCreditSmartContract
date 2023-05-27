// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./GTIDSAdminDao.sol";
import "./BCAgentDao.sol";
import "./FarmerDao.sol";
import "./WarehouseDao.sol";
import "./BankDao.sol";

contract MainContract {
    address private owner;
    GTIDSAdminContract private gtidsAdminContract;
    BCAgentContract private bcAgentContract;
    FarmerContract private farmerContract;
    WarehouseContract private warehouseContract;
    BankContract private bankContract;
    
    constructor() {
        owner = msg.sender;
        gtidsAdminContract = new GTIDSAdminContract();
        bcAgentContract = new BCAgentContract(address(this));
        farmerContract = new FarmerContract(address(this));
        warehouseContract = new WarehouseContract(address(this));
        bankContract = new BankContract(address(this));
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the GTIDS admin can perform this action.");
        _;
    }
    
    function addBCAgent(address _address, string memory _name, uint256 _age, string memory _Address, string memory _phoneNumber, string memory _bankDetails, string memory _kyc, string memory _plotNo, string memory _village, string memory _tehsil, string memory _block, string memory _district) public onlyOwner {
        bcAgentContract.addAgent(_address, _name, _age, _Address, _phoneNumber, _bankDetails, _kyc, _plotNo, _village, _tehsil, _block, _district);
    }
    
    function addFarmer(address _address, string memory _name, uint256 _age, string memory _Address, string memory _phoneNumber, string memory _bankDetails, string memory _kyc, string memory _plotNo, string memory _village, string memory _tehsil, string memory _block, string memory _district) public onlyOwner {
        farmerContract.addFarmer(_address, _name, _age, _Address, _phoneNumber, _bankDetails, _kyc, _plotNo, _village, _tehsil, _block, _district);
    }
    
    function addWarehouse(address _address, string memory _organization, string memory _name, string memory _Address, string memory _tinNo, string memory _gstinNo) public onlyOwner {
        warehouseContract.addWarehouse(_address, _organization, _name, _Address, _tinNo, _gstinNo);
    }
    
    function addBank(address _address, string memory _bankName, string memory _branch, string memory _ifscCode, string memory _district, string memory _state) public onlyOwner {
        bankContract.addBank(_address, _bankName, _branch, _ifscCode, _district, _state);
    }
    
    function addViewer(address _address) public onlyOwner {
        gtidsAdminContract.addViewer(_address);
        bcAgentContract.addViewer(_address);
        farmerContract.addViewer(_address);
        warehouseContract.addViewer(_address);
        bankContract.addViewer(_address);
    }
    
    function removeViewer(address _address) public onlyOwner {
        gtidsAdminContract.removeViewer(_address);
        bcAgentContract.removeViewer(_address);
        farmerContract.removeViewer(_address);
        warehouseContract.removeViewer(_address);
        bankContract.removeViewer(_address);
    }
    
    function getAdmin(address _address) public view returns (GTIDSAdminContract.GTIDSAdmin memory) {
        return gtidsAdminContract.getAdmin(_address);
    }
    
    function getAgent(address _address) public view returns (BCAgentContract.BCAgent memory) {
        return bcAgentContract.getAgent(_address);
    }
    
    function getFarmer(address _address) public view returns (FarmerContract.Farmer memory) {
        return farmerContract.getFarmer(_address);
    }
    
    function getWarehouse(address _address) public view returns (WarehouseContract.Warehouse memory) {
        return warehouseContract.getWarehouse(_address);
    }
    
    function getBank(address _address) public view returns (BankContract.Bank memory) {
        return bankContract.getBank(_address);
    }
}
