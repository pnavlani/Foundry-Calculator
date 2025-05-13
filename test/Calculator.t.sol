// License 
// SPDX-License-Identifier: LGPL-3.0-only

// Solidity version
pragma solidity ^0.8.0;

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
    /*
    function testFuzzAddition(uint256 a, uint256 b) public {
        if (a> type(uint256).max - b){
            vm.expectRevert("Addition overflow");
        }
        uint256 result = calculator.addition(a,b);
        assertTrue(true); // If it reaches here, the test passes
    }
    */

    function testSubstraction() public {
        uint256 result = calculator.substraction(10, 3);
        assertEq(result, 7, "Minus operation is incorrect");
    }

    function testSubstractionZeroResult() public {
        uint256 result = calculator.substraction(10,10);
        assertEq(result,0,"Substraction should result in zero");
    }


    function testMultiplier() public {
        uint256 result = calculator.multiplier(5,3);
        assertEq(result,15,"Multiplier operation is incorrect"); 
    }

    function testMultiplicationByZero() public {
        uint256 result = calculator.multiplier(10,0);
        assertEq(result, 0, "Multiplication by zero should be zero");
    }

    function testDivision() public {
        uint256 result = calculator.division(10,2);
        assertEq(result,5,"Division operation is incorrect");
    }
        /*
     function testDivisionByZero() public {
        vm.expectRevert("Division by zero");
        calculator.division(10, 0);
    } */

    function testExponentiation() public {
        uint256 result = calculator.exponentiation(2,3);
        assertEq(result,8,"Exponentiation operation is incorrect");
    }
        /*
    function testOnlyOwnerCanGetOperationDetails() public {
        vm.prank(address(0x123)); // Simulate that another account is calling the function
        calculator.addition(5,3); // We make the operation to create the historial
        vm.expectRevert("Only the owner can call this function");
        calculator.getOperationDetails(0);
    }
    */
    function testGetOperationDetails() public {
         calculator.addition(5,3);
        (string memory operationType, uint256 num1, uint256 num2, uint256 result, uint256 timestamp) = calculator.getOperationDetails(0);
        assertEq(num1,5,"Incorrect");
        assertEq(num2,3,"Incorrect");
        assertEq(result,8,"Incorrect");
        assertEq(keccak256(bytes(operationType)),keccak256(bytes("Addition")),"Incorrect");
    } 

    function testAdditionOverflow() public {
        uint256 maxUint = type(uint256).max;
        vm.expectRevert(); // We gonne wait for revert of transaction
        calculator.addition(maxUint, 1);
    }

     function testSubstractionOverflow() public {
        vm.expectRevert(); 
        calculator.substraction(0, 1);
    }

     function testMultiplicationOverflow() public {
        uint256 maxUint = type(uint256).max;
        vm.expectRevert(); 
        calculator.multiplier(maxUint, 2);
    }

     function testExponentiationOverflow() public {
        vm.expectRevert(); 
        calculator.exponentiation(2, 256); //Big exponentiation can cause overflow
    }

    function testGetOperationDetailsOutofBounds() public {
        vm.expectRevert("Index out of bounds");
        calculator.getOperationDetails(0); //Try to get details when the history is empty
    }


    
}