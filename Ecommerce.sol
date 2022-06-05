pragma solidity ^0.5.17;
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/IERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/access/roles/MinterRole.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/math/SafeMath.sol";

contract Ecommerce is MinterRole { 

    using SafeMath for uint;

    event ownership( address indexed who, uint indexed item_id,uint quantity);
    event withdrawall (address indexed from, uint amount);

    mapping (uint => uint) prices;
    mapping(address => mapping (uint => uint)) costumer_balance;
    address private _token_address;
    address payable _owner;

    constructor(address token_address) public{
        _owner = msg.sender;
        prices[0]=.1 ether;
        prices[1]=.1 ether;
        prices[2]=.1 ether;
        prices[3]=.1 ether;
        prices[4]=.1 ether;
        _token_address = token_address;
    }
    function destroy() public onlyMinter{
        selfdestruct(_owner);
    }
    function ownershipOf(address who,uint item_id) public view returns(uint256) {return costumer_balance[who][item_id];}
    function SetAddress(address token_address) external onlyMinter {
        _token_address=token_address;
    }
    function SetPrice(uint item_id, uint new_price) public onlyMinter {
        prices[item_id]=new_price;
    }
    function calculate_amount(uint item_id, uint quantity) external view returns (uint256 ) {return prices[item_id].mul(quantity);}
    function buy (uint item_id, uint quantity) external{
        IERC20 token_contract = IERC20(_token_address);
        uint total_amount= prices[item_id].mul(quantity);
        costumer_balance[msg.sender][item_id]+=quantity;
        token_contract.transferFrom(msg.sender,address(this),total_amount);
        emit ownership(msg.sender,item_id,quantity);
    }
    function withdrawAll() external onlyMinter {
        IERC20 token_contract = IERC20(_token_address);
        uint total_amount=token_contract.balanceOf(address(this));
        token_contract.transferFrom(address(this), msg.sender, total_amount);
        emit withdrawall(msg.sender, total_amount);
    }
}
