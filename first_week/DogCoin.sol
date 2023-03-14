// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract DogCoin {
    
    uint256 totalSupply = 2000000;
    uint64 increaseAmount = 1000;
    address owner;
    mapping (address => uint256) public balances;
    mapping (address => Payment[]) paymentsConfirmList;
     

    struct Payment{
        address recipient;
        uint transferedAmount;
    }
    Payment flag;

    event supplyChange(uint256);
    event checkTransfer(address from, address to, uint amount);


    modifier onlyOwner() {
        require(msg.sender==owner, "You are not the owner");
        _;
    }

    function getTotalSupply() public view returns(uint256) {
        return totalSupply;
    }

    function getPaymentsList(address searchAddress) public view returns(Payment[] memory) {
        return paymentsConfirmList[searchAddress];
    }

    // function to increase supply by 1000
    function increaseSupply() public onlyOwner {
        totalSupply += increaseAmount;
        emit supplyChange(totalSupply);
    }

    // Custom Error 
    // To define the custom error in the smart contract by using the “Error statement” . 
    // Error statement is used either inside the smart contract or outside the smart contract along with revert statement. 
    // The main purpose of using custom error in the smart contract is to save gas.
    
    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    // also checking if the amount we insert is available
    function transfer(address recipient, uint amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        flag = Payment(recipient, amount);
        paymentsConfirmList[recipient].push(flag);
        emit checkTransfer(msg.sender, recipient, amount);
    }

    constructor() {
        owner = msg.sender;
        balances[owner] = getTotalSupply();
    }
}