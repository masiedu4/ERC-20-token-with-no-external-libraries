// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath { // Only relevant functions
function sub(uint256 a, uint256 b) internal pure returns (uint256) {
  assert(b <= a);
  return a-b;
  
}

function add(uint256 a, uint256 b) internal pure returns (uint256)   {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}
}

contract ERC20  { 

    using SafeMath for uint256;

    // used to emit Approval of accounts
    event Approval(address indexed tokenOwner, address indexed spender,
 uint tokens);

 // used to emit succesful transfers
event Transfer(address indexed from, address indexed to,
 uint tokens);

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    // variable to hold the total supply of our token
    uint256 totalSupply;  

    // our constructor takes on input that sets the total suuply upon deployment
    constructor(uint _totalSupply) {
        totalSupply = _totalSupply;

        //this code of line gives to the total supply to the owner of the contract
        balances[msg.sender] = totalSupply;
    }

    //retrieve the total suuply
    function totalSupply_ () public view returns(uint256) {
        return totalSupply;
    }

    //get the balance of a particular account
    function getBalance(address tokenOwner) public view returns(uint) {
        return balances[tokenOwner];
    }

    // transfer token
    function sendToken (address receiver , uint numOfTokens) public returns(bool) {
        // check if the sender has the amount in his wallet
        require(numOfTokens < balances[msg.sender], "You dont have enough to transfer");
        // deduct number of tokens sent from the sender's balance
        balances[msg.sender] = balances[msg.sender].sub(numOfTokens);

        // add the number of tokens to the receiver
        balances[receiver] = balances[receiver].add(numOfTokens);
        
        // emit Transfer event when succesful
        emit Transfer(msg.sender , receiver , numOfTokens);

        // return  true if the operation is succesful
        return true;
    }  
      // approve delegate to be able to transfer from your account 
      function approve (address owner , address delegate , uint numOfTokens) public returns(bool){
          // delegate the number of the tokens to an account
          allowed[owner][delegate] = numOfTokens;
          // emit when successful
          emit Approval (owner , delegate , numOfTokens);

          return true;       
      }

     // Get Number of Tokens Approved for Withdrawal by delegate
      function getApprovedTokens (address owner , address delegate) public view returns(uint) {
          return allowed[owner][delegate];
      }

      // Transfer Tokens by Delegate
      function transferByDelegate (address owner ,address recipient , uint numOfTokens) public returns(bool) {
        // check if the owner has enough to transfer
          require(numOfTokens < balances[owner], "Not enough in the owner account");
          
          // check if the delegate has enough allowed tokens
          require(numOfTokens < allowed[owner][msg.sender], "Delegate doesn't have enough to transfer");

          // deduct the amount to transfer from the ownera account
          balances[owner] = balances[owner].sub(numOfTokens);

          // reduce the delegate's allowed amount
          allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numOfTokens);

          // add the amount to the recipient balances
          balances[recipient] = balances[recipient].add(numOfTokens);

          // emit Transfer event if successful
          emit Transfer(owner , recipient , numOfTokens);

          return true;

      }







}



