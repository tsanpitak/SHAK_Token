pragma solidity >= 0.5.0 < 0.6.0;

import "./Token.sol";
import "https://github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

contract EIP823SenderI {
    
    mapping ( address => uint ) private exchangedWith;
    mapping ( address => uint ) private exhangedBy;
    
    event Exchange(address _from, address _targetContract, uint _amount);
    event ExchangeSpent(address _from, address _targetContract, address _to, uint _amount);
    
    function exchangeToken(address _targetContract, uint _amount) public returns(bool success, uint creditedAmount);
    function exchangeAndSpend(address _targetContract, uint _amount,address _to) public returns(bool success);
    function __exchangerCallback(address _targetContract,address _exchanger, uint _amount) public returns(bool success);
}

contract EIP823RecvI {
    mapping ( address => uint ) private exchangesReceived;
    
    event Exchange(address _from, address _with, uint _amount);
    event ExchangeSpent(address _from, address _targetContract, address _to, uint _amount);
    
    function __targetExchangeCallback (uint _to, uint _amount) public returns(bool success);
    function __targetExchangeAndSpendCallback (address _from, address _to, uint _amount) public returns(bool success);
}

contract EIP823ServiceI {
    address[] private registeredTokens;
    
    event Exchange( address _from, address _by, uint _value ,address _target );
    event ExchangeAndSpent ( address _from, address _by, uint _value ,address _target ,address _to);
    
    function registerToken(address _token) public returns(bool success);
    function exchangeToken(address _targetContract, uint _amount, address _from) public returns(bool success, uint creditedAmount);
    function exchangeAndSpend(address _targetContract, uint _amount, address _from, address _to) public returns(bool success);
}

contract Bank is usingOraclize {
    using SafeMath for uint;
    
    uint coinTotal;
    string private constant orcl_url = "json(http://04517724.ngrok.io/prediction/api/v1.0/some_prediction?f1=1&f2=1&f3=1).result";
    
    // Address where we'll hold all ETH
    address payable private fundwallet = msg.sender;
    uint private rate;
    
    mapping(address => uint) balances;
    
    event LogNewOraclizeQuery(string description);
    event sellTokenEvent(address _from, address _to, uint _amountToken, uint _amountETH);
    event buyBackTokenEvent(address _to, uint _amountToken, uint _amountETH);
    event transferTokenEvent(address _from, address _to, uint _amountToken);
    
    modifier onlyFund {
        require(msg.sender == fundwallet, "You do not have permission!");
        _;
    }
    
    constructor(uint _rate, address payable _fundwallet) public payable {
        //Assign where to hold the funds
        fundwallet = _fundwallet;
        rate = _rate;
    }
    
    function getRate() public view returns (uint) { return rate; }
    function setRate(uint _rate) public onlyFund { rate = _rate; }
    function coinBalance () public view returns (uint) { return balances[msg.sender]; }
    
    function sellToken(address payable _source, address payable _recv) public returns (bool) {
        // updateRate
        // calculate amount of tokens from msg.value
        // transfer ETH from _source to fundwallet
        // mint tokens to _recv
        // update coinTotal
        // update Oracalize
        // emit event
        // return true if succeed
    }
    
    function buyBackToken(address payable _source, address payable _recv, uint amount) public returns (bool) {
        // check whether _source can cover buyBack
        // calculate amount of ETH
        // deduct tokens
        // deduct coinTotal
        // transfer ETH from fundwallet
        // update Oracalize
        // emit event
        // returns true if succeed
    }
    
    function transferToken(address payable _source, address payable _recv, uint amount) public returns (bool) {
        // check whether _source can cover transfer
        // deduct from _source
        // update _recv
        // emit event
        // returns true if succeed
    }
    
    function __callback(bytes32 myid, string memory result, bytes memory proof) public {
            //This function is executed after the result from Oracalize
           require(msg.sender == oraclize_cbAddress()); 
           rate = parseInt(result);
    }
    
    function __callback(bytes32 myid, string memory result) public {
            //This function is executed after the result from Oracalize
           require(msg.sender == oraclize_cbAddress()); 
           rate = parseInt(result);
    }
    
    function updateRate() private {
        // When this function is called it calls our sklearn model is queried.
        if (oraclize_getPrice("URL") > address(this).balance) { //Makes sure that you have ETH to cover query
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            //Here we execute the query
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer.."); 
            oraclize_query("URL", orcl_url);
        }
    }
}