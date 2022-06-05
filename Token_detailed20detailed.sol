pragma solidity ^0.5.17;
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/ERC20.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/access/roles/MinterRole.sol";
import "OpenZeppelin/openzeppelin-contracts@2.5.0/contracts/token/ERC20/ERC20mintable.sol";

contract Ragublo is ERC20Mintable, ERC20Detailed {
    constructor (string memory name, string memory symbol, uint8 decimals) ERC20Detailed (name,symbol,decimals) public {
    }
}

