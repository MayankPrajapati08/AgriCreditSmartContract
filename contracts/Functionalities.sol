// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Functionalities {
    address public gtidsAdmin;
    address public warehouse;
    address public bank;
    address public farmer;
    address public bcAgent;

    mapping(address => uint256) public goodsStored;
    mapping(address => bool) public isContractSigned;
    mapping(address => bool) public isLoanTaken;

    event GoodsStored(address indexed farmer, uint256 amount);
    event ContractSigned(address indexed farmer, address indexed warehouse);
    event LoanTaken(address indexed farmer, address indexed bank);
    event LoanRepaid(address indexed farmer, address indexed bank);

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
        // Assuming the bank has its own ownership tracking mechanism
        // You may need to modify this part to fit your specific requirements

        isLoanTaken[farmer] = true;
        emit LoanTaken(farmer, bank);
    }

    function repayLoan() external {
        require(msg.sender == farmer, "Only the farmer can repay the loan.");
        require(isLoanTaken[farmer], "No loan has been taken for the goods.");

        // Repay the loan to the bank
        // Assuming the bank has its own loan repayment mechanism
        // You may need to modify this part to fit your specific requirements

        isLoanTaken[farmer] = false;
        emit LoanRepaid(farmer, bank);
    }
}
