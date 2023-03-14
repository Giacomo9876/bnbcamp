// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BadgerCoin is ERC20, Ownable {
    constructor() ERC20("BadgerCoin", "BC") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

// Solution with teammates


// SPDX-License-Identifier: MIT
// pragma solidity 0.8.9;

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract BadgerCoin is ERC20, Ownable {

//     constructor() ERC20("BadgerCoin", "BC") {
//         _mint(msg.sender, 1000000 * 10 ** 18);
//     }

//     function mint(address to, uint256 amount) public onlyOwner {
//         _mint(to, amount);
//     }

//     // the getOwner() function is required to be BEP20 compliant
//     function getOwner() public view returns(address) {
//         return owner();
//     }
// }