// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract SupplyChain {
    address public gtidsAdmin;
    address public warehouse;
    address public bank;
    address public farmer;
    address public bcAgent;

    mapping(address => uint256) public goodsStored;
    mapping(address => bool) public isContractSigned;
    mapping(address => bool) public isLoanTaken;
    mapping(address => address) public ownership;

    event GoodsStored(address indexed farmer, uint256 amount);
    event ContractSigned(address indexed farmer, address indexed warehouse);
    event LoanTaken(address indexed farmer, address indexed bank);
    event LoanRepaid(address indexed farmer, address indexed bank);
    event OwnershipTransferred(address indexed farmer, address indexed bank);

    constructor(
        address _gtidsAdmin,
        address _warehouse,
        address _bank,
        address _farmer,
        address _bcAgent
    ) {
        gtidsAdmin = _gtidsAdmin;
        warehouse = _warehouse;
        bank = _bank;
        farmer = _farmer;
        bcAgent = _bcAgent;
    }

    function storeGoods(uint256 amount) external {
        require(msg.sender == farmer, "Only the farmer can store goods.");
        goodsStored[farmer] = amount;
        emit GoodsStored(farmer, amount);

        // To-do :- add details of stored goods. 
    }

    function signContract() external {
        require(msg.sender == farmer, "Only the farmer can sign the contract.");
        require(!isContractSigned[farmer], "Contract already signed.");
        isContractSigned[farmer] = true;
        emit ContractSigned(farmer, warehouse);
    }

    function transferOwnershipToBank() external {
        require(
            msg.sender == farmer,
            "Only the farmer can transfer ownership to the bank."
        );
        require(
            isContractSigned[farmer],
            "Contract must be signed before transferring ownership."
        );
        require(
            !isLoanTaken[farmer],
            "Loan has already been taken for the goods."
        );

        // Transfer ownership to the bank
        ownership[farmer] = bank;
        isLoanTaken[farmer] = true;
        emit OwnershipTransferred(farmer, bank);
        emit LoanTaken(farmer, bank);
    }

    function repayLoan() external {
        require(msg.sender == farmer, "Only the farmer can repay the loan.");
        require(isLoanTaken[farmer], "No loan has been taken for the goods.");

        ownership[farmer] = farmer;
        isLoanTaken[farmer] = false;
        emit OwnershipTransferred(farmer, farmer);
        emit LoanRepaid(farmer, bank);
    }
}
