// License 
// SPDX-License-Identifier: LGPL-3.0-only

// Solidity version
pragma solidity 0.8.24;

import "../src/Calc.sol";
import "forge-std/Test.sol";

contract CalcTest is Test {

    Calc calculator; // Instance of the contract
    uint256 public firstResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);
    function setUp() public {
        calculator = new Calc(firstResult,  admin);

    }

    function testCheckFirstResult() public view {
       uint256 firstResult_ =  calculator.result();
      assert( firstResult_ == firstResult);

    }

    function testAddition() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculator.addition(firstNumber_, secondNumber_);

        assert(result_ == firstNumber_ + secondNumber_);
    }

    function testSubstraction() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculator.substraction(firstNumber_, secondNumber_);

        assert(result_ == firstNumber_ - secondNumber_);
    }

    function testMultiplier() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculator.multiplier(firstNumber_, secondNumber_);

        assert(result_ == firstNumber_ * secondNumber_);
    }

    function testCanNotMultiply2LargeNumbers() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 115792089237316195423570985008687907853269984665640564039457584007913129639934;
    }

    function testIfNotAdminCallsDivisionReverts() public {
        vm.startPrank(randomUser);
        
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        vm.expectRevert();
        calculator.division(firstNumber_, secondNumber_);
    
        vm.stopPrank(); 
    }

  
    function testAdminCanCallDivisionCorrectly() public {
         vm.startPrank(admin);
        
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        calculator.division(firstNumber_, secondNumber_);
    
        vm.stopPrank(); 
    }

     function testDefaultCanCallDivisionCorrectly() public {
    
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        console.log(msg.sender);
        vm.expectRevert();

        calculator.division(firstNumber_, secondNumber_);
       
    }


    function testDefaultExecutesCorrectly() public{
        vm.startPrank(admin);

        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;
        uint256 result_ = calculator.division(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ / secondNumber_);
        vm.stopPrank();
    }


    function testCanNotDivideByZero() public {
         vm.startPrank(admin);

        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 0;
        vm.expectRevert();
        calculator.division(firstNumber_, secondNumber_);
        
        vm.stopPrank();
    }

    // Fuzzing testing 
    

    // Fuzzing test
    function testFuzzingDivision(uint256 firstNumber_, uint256 secondNumber_) public {
          vm.startPrank(admin);

        
        calculator.division(firstNumber_, secondNumber_);
        
        vm.stopPrank();
    }







      

}
