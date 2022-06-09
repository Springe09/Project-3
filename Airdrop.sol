pragma solidity ^0.8.4;


import "./GameOfToken.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/MerkleProof.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.6/contracts/token/ERC20/ERC20.sol";
import "https://github.com/NomicFoundation/hardhat/blob/master/packages/hardhat-core/console.sol";



contract AirDrop is ERC20 ("GameOfToken", "GOT") {
//root-database lookup for whose eligible for AirDrop
//immutable =only be assigned once.
    bytes32 public immutable root;
    uint256 public immutable rewardAmount;
    mapping(address => bool) claimed;

    constructor(bytes32 _root, uint256 _rewardAmount) {
            root=_root;
    
            rewardAmount= _rewardAmount;
    }
//take person address and hash it and put that in the function -person calling claim
//keep track of those who have already calimed tokens
    function claim(bytes32[] calldata _proof) external {
        require(!claimed[msg.sender], "Already claimed air drop");
        claimed[msg.sender]= true;
        //Keccak256 is a cryptographic function built into solidity. This function takes in any amount of inputs and converts it to a unique 32 byte hash.
        bytes32 _leaf =keccak256(abi.encodePacked(msg.sender));//person calling claim
        require(MerkleProof.verify(_proof, root, _leaf), "Incorrect Merkle Proof");

        _mint(msg.sender, rewardAmount);
       
    }
}


//Inherit from ERC20 
//3 components verify (proof, root, leaf)
//store proof in contract
//how many tokens can they claim 
//run once and only once
//pass in root and reward amount 