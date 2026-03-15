// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UniversityRegistry {
    
    // Owner = you (the admin)
    address public owner;
    
    // Maps wallet address → university name
    mapping(address => string) public universityNames;
    
    // Maps wallet address → is registered or not
    mapping(address => bool) public isRegistered;

    event UniversityAdded(address indexed uniAddress, string name);
    event UniversityRemoved(address indexed uniAddress);

    // When contract is deployed, YOU become the owner
    constructor() {
        owner = msg.sender;
    }

    // Only YOU (admin) can call this
    modifier onlyOwner() {
        require(msg.sender == owner, "Only admin can do this!");
        _;
    }

    // Add a university (only admin)
    function addUniversity(address uniAddress, string memory name) external onlyOwner {
        universityNames[uniAddress] = name;
        isRegistered[uniAddress] = true;
        emit UniversityAdded(uniAddress, name);
    }

    // Remove a university (only admin)
    function removeUniversity(address uniAddress) external onlyOwner {
        universityNames[uniAddress] = "";
        isRegistered[uniAddress] = false;
        emit UniversityRemoved(uniAddress);
    }

    // Anyone can check if a university is registered
    function getUniversity(address uniAddress) external view returns (bool, string memory) {
        return (isRegistered[uniAddress], universityNames[uniAddress]);
    }
}
