// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateRegistry {
    mapping(bytes32 => mapping(address => uint256)) public certificates;

    event CertificateIssued(bytes32 indexed certHash, address indexed issuer);
    event CertificateRevoked(bytes32 indexed certHash, address indexed issuer);

    function issueCertificate(bytes32 certHash) external {
        require(certificates[certHash][msg.sender] == 0, "Already issued");
        certificates[certHash][msg.sender] = block.timestamp;
        emit CertificateIssued(certHash, msg.sender);
    }

    function verifyCertificate(
        bytes32 certHash,
        address issuer
    ) external view returns (uint256 issuedAt) {
        return certificates[certHash][issuer];
    }

    function revokeCertificate(bytes32 certHash) external {
        require(certificates[certHash][msg.sender] != 0, "Not found");
        delete certificates[certHash][msg.sender];
        emit CertificateRevoked(certHash, msg.sender);
    }
}
