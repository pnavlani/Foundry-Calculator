// License 
// SPDX-License-Identifier: LGPL-3.0-only

// Solidity version
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/Calculator.sol";

contract CalculatorTest is Test {

    Calculator public calculator; //Instance of contract

    function setUp() public {
        calculator = new Calculator(); // Display contract before the test

    }

    function testAddition() public {
        uint256 result = calculator.addition(5, 3);
        assertEq(result, 8, "Plus operation is incorrect");
    }

    function testSubstraction() public {
        uint256 result = calculator.substraction(10, 3);
        assertEq(result, 7, "Minus operation is incorrect");
    }

    function testMultiplier() public {
        uint256 result = calculator.multiplier(5,3);
        assertEq(result,15,"Multiplier operation is incorrect"); 
    }

    function testOnlyOwnerCanGetOperationDetails() public {
        vm.prank(address(0x123)); // Simulate that another account is calling the function
        calculator.addition(5,3); // We make the operation to create the historial
        vm.expectRevert("Only the owner can call this function");
        calculator.getOperationDetails(0);
    }

    function testGetOperationDetails() public {
         calculator.addition(5,3);
        (string memory operationType, uint256 num1, uint256 num2, uint256 result, uint256 timestamp) = calculator.getOperationDetails(0);
        assertEq(num1,5,"Incorrect");
        assertEq(num2,3,"Incorrect");
        assertEq(result,8,"Incorrect");
        assertEq(keccak256(bytes(operationType)),keccak256(bytes("Addition")),"Incorrect");
    }
    
}