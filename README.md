# Smart Contract Calculator 🧮

## Overview

This project showcases a simple yet secure Smart Contract Calculator, built in Solidity. It supports fundamental arithmetic operations and maintains a detailed history of calculations. Developed using [Foundry](https://book.getfoundry.sh/), it emphasizes testing and security best practices.

## Features

*   **Core Arithmetic Operations:** Implements addition, subtraction, multiplication, division, and exponentiation for `uint256` numbers.
*   **Detailed Operation History:** Records each operation performed, including the operation type, input values, result, and timestamp, enabling auditing and analysis.
*   **Ownership Control:** Restricts access to operation history details to the contract owner only, ensuring data privacy.
*   **Overflow and Underflow Protection:** Leverages Solidity 0.8+'s built-in arithmetic overflow/underflow protection and adds explicit checks for enhanced security and clarity.

## Smart Contract Details

*   **Contract Name:** `Calculator`
*   **Solidity Version:** `^0.8.0`
*   **Dependencies:** No external dependencies required.

### Core Functions

1.  **`addition(uint256 num1_, uint256 num2_)`**

    *   Adds two unsigned integers.
    *   Includes an explicit overflow check using `require`, even though Solidity 0.8+ reverts on overflow. This demonstrates awareness of overflow risks and provides an extra layer of security.
    *   Emits an `Addition` event upon successful execution.

    ```solidity
    function addition(uint256 num1_, uint256 num2_) public returns (uint256 result_) {
        result_ = num1_ + num2_;
        require(num1_ + num2_ >= num1_, "Addition overflow");
        history.push(Operation("Addition",num1_,num2_,result_, block.timestamp));
        emit Addition(num1_,num2_,result_);
        return result_;
    }
    ```

2.  **`substraction(uint256 num1_, uint256 num2_)`**

    *   Subtracts `num2_` from `num1_`, reverting on underflow (handled automatically by Solidity 0.8+).
    *   Emits a `Substraction` event.

    ```solidity
    function substraction(uint256 num1_, uint256 num2_) public  returns(uint256 result_){
        result_ = num1_ - num2_;
        history.push(Operation("Substraction", num1_,num2_, result_, block.timestamp));
        emit Substraction(num1_, num2_, result_);
        return result_;
    }
    ```

3.  **`multiplier(uint256 num1_, uint256 num2_)`**

    *   Multiplies two unsigned integers, reverting on overflow (handled automatically by Solidity 0.8+).
    *   Emits a `Multiplier` event.

    ```solidity
    function multiplier(uint256 num1_,uint256 num2_) public returns (uint256 result_){
        result_ = num1_ * num2_;
        history.push(Operation("Multiplier",num1_,num2_,result_,block.timestamp));
        emit Multiplier(num1_,num2_,result_);
        return result_;
    }
    ```

4.  **`division(uint256 num1_, uint256 num2_)`**

    *   Divides `num1_` by `num2_`, ensuring `num2_` is not zero to prevent division by zero errors.
    *   Emits a `Division` event.

    ```solidity
    function division(uint256 num1_,uint256 num2_) public returns (uint256 result_){
        if (num1_ != 0 && num2_ != 0) { 
        result_ = num1_ / num2_;
        history.push(Operation("Division",num1_,num2_,result_,block.timestamp));
        emit Division(num1_,num2_,result_);
        return result_;
        }
    }
    ```

5.  **`exponentiation(uint256 base_, uint256 exponent_)`**

    *   Calculates `base_` raised to the power of `exponent_`.
    *   Uses a helper function `power` for calculation.
    *   Emits an `Exponentiation` event.

    ```solidity
    function exponentiation(uint256 base_, uint256 exponent_) public returns (uint256 result_) {
        result_ = power(base_, exponent_);
        history.push(Operation("Exponentiation", base_, exponent_, result_, block.timestamp));
        emit Exponentiation(base_, exponent_, result_);
        return result_;
    }
    ```

6.  **`getOperationDetails(uint256 index)`**

    *   Retrieves details of an operation from the history array at the specified `index`.
    *   Restricted to the contract owner using the `onlyOwner` modifier.
    *   Reverts if the index is out of bounds.

    ```solidity
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
    ```

### Testing with Foundry🧪

Comprehensive testing has been implemented using Foundry to ensure the calculator functions correctly and securely. The `CalculatorTest.sol` file includes tests for:

*   Verifying correct arithmetic results.
*   Confirming that division by zero reverts.
*   Ensuring that the explicit overflow check in addition works as expected.
*   Validating that operations revert on overflow and underflow (leveraging Solidity 0.8+'s built-in protection).
*   Testing access control restrictions for sensitive functions.
*   Testing boundary conditions like division by zero and out of bounds indexes.

## Deployment Instructions📋

1.  **Install Foundry:** Follow the instructions on the [Foundry Book](https://book.getfoundry.sh/) to install Foundry.
2.  **Clone the Repository:**
    ```bash
    git clone <repository_url>
    cd smart-contract-calculator
    ```
3.  **Compile the Contract:**
    ```bash
    forge build
    ```
4.  **Deploy the Contract:** You can deploy the contract using Foundry's `create` command or through a script.  See the Foundry documentation for details.

## Technologies Used

*   **Solidity `^0.8.0`:** Smart contract programming language for implementing the calculator logic.
*   **Foundry:** A fast, portable, and modular toolkit for Ethereum application development. Used for compiling, testing, and deploying the contract.

## License🪪

This project is licensed under the **LGPL-3.0-only** license.

## Future Enhancements🔮

*   **Implement a user interface (DApp):** To allow users to easily interact with the calculator.
*   **Add more advanced mathematical functions:** such as square root, trigonometry, and logarithms.
*   **Implement a gas optimization strategy:** To reduce costs for more complex calculations.
*   **Explore fixed-point arithmetic:** To handle decimals.

