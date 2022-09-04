//SPDX-License-Identifier: GPL-3.0
//This is a NFt mint smart-contract using the ERC721 standard
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract SimpleMint is ERC721,Ownable {
    uint public mintPrice = 0.05 ether;
    uint public totalSupply;
    uint public maxSupply;
    bool public isMintEnabled;
    mapping(address=>uint) public mintedWallets;

    constructor() payable ERC721('Simple Mint','SIMPLEMINT'){
        maxSupply = 2;
    }

    function toggleIsMintEnabled() external onlyOwner{
        isMintEnabled = !isMintEnabled;
    }
    function setMaxSupply(uint256 _maxSupply)external onlyOwner{
        maxSupply = _maxSupply;
    }
    
    function mint() external payable{
        require(isMintEnabled,"minting is not enables");
        require(mintedWallets[msg.sender]<1,'exceeds max per wallets');
        require(msg.value == mintPrice,"wrong value");
        require(maxSupply > totalSupply,'sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint tokenId = totalSupply;
        _safeMint(msg.sender,tokenId);
    }
}
