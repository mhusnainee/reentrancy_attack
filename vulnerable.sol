// SPDX-License-Identifier: MIT

 /*
 * This Smart contract is vilnerable for reentrancy attack
 * And attacker will exploit this vulnerability to withdraw funds
 */
pragma solidity >=0.7.0 <0.9.0;

contract vulnerable {

    /*
     * Mapping to store balances of users
     */
    mapping(address => uint) public balances;

    /*
    * @dev deposit function will be called by user or attacker contract to deposit funds
    */
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /**
    * @dev withdraw will be called by user or contract to withdraw funds
    * 
    * Requirements:
    * User'sbalance should be greater than zero
    */
    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0, "Not enough balance");
        (bool sent, ) = msg.sender.call{value: bal}("");

        require(sent, "Sent unsuccessfull");
        balances[msg.sender] = 0;
    }

    /**
    * @dev getBalance will return the balance of this contract
    */
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

}
