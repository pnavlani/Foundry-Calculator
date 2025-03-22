// License 
// SPDX-License-Identifier: LGPL-3.0-only

// Solidity version
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/math/Math.sol";

//Contract 
contract Calculator{

    //Variables
   // uint256 public result = 10;  // [ 0- 2^256 - 1 ]
    address public owner;


    struct Operation {
        string operationType;   // "Addition" or "Substracction", etc
        uint256 num1;   
        uint256 num2;
        uint256 result;
        uint256 timestamp; //Time of execution
    }

    Operation[] public history; //Array to store operation history

    //Events
    event Addition(uint256 number1, uint256 number2, uint256 result);
    event Substraction(uint256 number1, uint256 number2, uint256 result);
    event Multiplier(uint256 number1, uint256 number2, uint256 result);
    event Division(uint256 number1, uint256 number2, uint256 result);
    event Exponentiation(uint256 base, uint256 exponent, uint256 result);
    
    // Constructor to set the Owner
    constructor() {
        owner = msg.sender;
    }   

     //Modifiers
   
   /* modifier checkNumber(uint num1_){
        if(num1_ != 10) revert();
        _;
    } */

   
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    //External Functions
     
   // Adds two numbers and stores the result in history 
    function addition(uint256 num1_, uint num2_) public  returns (uint256 result_) {
        result_ = num1_+ num2_;
        history.push(Operation("Addition",num1_,num2_,result_, block.timestamp));
        emit Addition(num1_,num2_,result_);
        return result_;
    }

    //Substracts the second number from the first and stores the result in history
    function substraction(uint256 num1_, uint256 num2_) public  returns(uint256 result_){
        result_ = num1_ - num2_;
        history.push(Operation("Substraction", num1_,num2_, result_, block.timestamp));
        emit Substraction(num1_, num2_, result_);
        return result_;
    }

   

    //Multiplies the two input numbers and stores the result in history
    function multiplier(uint256 num1_,uint256 num2_) public returns (uint256 result_){
        result_ = num1_ * num2_;
        history.push(Operation("Multiplier",num1_,num2_,result_,block.timestamp));
        emit Multiplier(num1_,num2_,result_);
        return result_;
    }

     //Divides the first number by the second and stores the result in history
    function division(uint256 num1_,uint256 num2_) public returns (uint256 result_){
        result_ = num1_ / num2_;
        history.push(Operation("Division",num1_,num2_,result_,block.timestamp));
        emit Division(num1_,num2_,result_);
        return result_;
    }

    // Exponentiation of the first number by the second and stores the result in history
    function exponentiation(uint256 base_, uint256 exponent_) public returns (uint256 result_) {
        result_ = Math.pow(base_, exponent_);
        history.push(Operation("Exponentiation", base_, exponent_, result_, block.timestamp));
        emit Exponentiation(base_, exponent_, result_);
        return result_;
    }
    // Returns the length of the operation history
    function getHistoryLength() public view returns (uint256) {
        return history.length;
    }

    // Returns detailed information about an operation at a given index
    function getOperationDetails(uint256 index) public view onlyOwner returns  (
        string memory operationType,
        uint256 num1,
        uint256 num2,
        uint256 result,
        uint256 timestamp
    ){
        require(index < history.length, "Index out of bounds");
        Operation memory op = history[index];
        return (op.operationType, op.num1, op.num2, op.result, op.timestamp);

    }
    

    





}