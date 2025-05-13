// License 
// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

contract Calc {
    
    //Varaibles
    uint256 public result;
    address public admin;

    //Events 
    event Addition (uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Substraction (uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Multiplier (uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Division (uint256 firstNumber_, uint256 secondNumber_, uint256 result_);

    // Modifier 
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
           _;
    }
    constructor(uint256 firstResult_, address admin_){
        result = firstResult_;
        admin = admin_;
    }

    //Functions

    //Addition 
    function addition(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_  + secondNumber_;
        result = result_;

        emit Addition(firstNumber_, secondNumber_, result_);
    }
    //Substraction

    function substraction(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_ - secondNumber_;
        result = result_;
        emit Substraction(firstNumber_, secondNumber_, result_);
    }


    // Multiplier
    function multiplier(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_ * secondNumber_;
        result = result_;
        emit Multiplier(firstNumber_, secondNumber_, result_);
    }

    // Division 
    function division(uint256 firstNumber_, uint256 secondNumber_) external onlyAdmin returns(uint256 result_){
        if (secondNumber_ == 0) return 0;
        require(secondNumber_ != 0, "Division by zero");
        result_ = firstNumber_ / secondNumber_;
        result = result_;
        emit Division(firstNumber_, secondNumber_, result_);
    }
}

