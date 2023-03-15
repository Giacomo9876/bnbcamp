// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../contracts/BadgerNFT.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    using Counters for Counters.Counter;

    Counters.Counter public _tokenIdCounter;

    address owner;
    address zeroAddress;
    uint tokenId;
    ERC721 cazzo;
    Badger badger;
    mapping(uint256 => address) public owners;

    

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // <instantiate contract>
        owner = msg.sender;
        zeroAddress = 0x0000000000000000000000000000000000000000;
        tokenId = 0;
        badger = new Badger();

    }
    
    function checkFailureMint() public {
        badger.safeMint(owner);
        Assert.notEqual(tokenId, uint(0), "tokenid should increment not equal 0");
    }


    function checkMint() public {
        // account index varies 0-9, value is in wei
        badger.safeMint(zeroAddress);
        Assert.equal(tokenId + 1, 1, "Token created wrongly");
        Assert.equal(owner, 0x0000000000000000000000000000000000000000, "ERC721: mint to the zero address");
        Assert.equal(address(msg.sender), TestsAccounts.getAccount(1), "New Token Mintend");

        //require(to != address(0), "ERC721: mint to the zero address");
        //require(!_exists(tokenId), "ERC721: token already minted");
    }

    function checkSafeTransfer() public payable {
        // account index varies 0-9, value is in wei
        Assert.equal(badger.ownerOf(tokenId) , owner,"ERC721: transfer from incorrect owner");
        Assert.equal(badger.ownerOf(tokenId) , zeroAddress,"ERC721: transfer to the zero address");
        //Assert.equal(badger.safeTransferFrom(owner, zeroAddress, tokenId) , zeroAddress,"ERC721: transfer to zero address ");
        //require(ERC721.ownerOf(tokenId) == from, "ERC721: transfer from incorrect owner");
        //require(to != address(0), "ERC721: transfer to the zero address");
    }



}
    