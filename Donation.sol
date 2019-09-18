pragma solidity ^0.4.0;

contract Donation {
   
    address public ngoowner;
    address public payee;
    mapping (address => uint) public balances;
     
     
    struct Payee {

    bool status;
    uint weight;
      
  }
  
  mapping(address => Payee) public payees;


  
  event PayeeAction(address indexed payee, bytes32 action);
  event Sent(address from, address to, uint amount);

   
    function Donation() public{
       
        ngoowner = msg.sender;
    payees[ngoowner].status = true;
    payees[ngoowner].weight = 10;
  
    }
    
    modifier isOwner() {
      if (msg.sender != ngoowner) throw;
      _;
  }


  modifier isPayee() {
    if (payees[msg.sender].status != true) throw;
    _;
  }
  
  
   function addPayee(address _payee, uint _weight) isOwner returns (bool) {

    payees[_payee].weight = _weight;
    payees[_payee].status = true;
   
    PayeeAction(_payee, 'added');
  }


    
    function addamount(address receiver, uint amount) public  {
        payee = msg.sender;
        if (msg.sender != payee) return;
        balances[receiver] += amount;
    }

    function donationamount(address receiver, uint amount) public {
        payee = msg.sender;
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Sent(msg.sender, receiver, amount);
    }
}
