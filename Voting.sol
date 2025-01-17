// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Use a mapping to store candidate votes (efficient storage)
    mapping(address => uint8) private votes; // Votes for each candidate

    // Use an array to track candidate addresses for iteration
    address[] private candidates;

    // Owner address (minimized storage size)
    address private immutable owner;

    // Constructor to set the owner
    constructor() {
        owner = msg.sender; // Use immutable to save gas for read-only access
    }

    // Add a new candidate (only the owner can add candidates)
    function addCandidate(address candidate) external {
        require(msg.sender == owner, "Only owner can add candidates");
        require(votes[candidate] == 0, "Candidate already exists");
        candidates.push(candidate);
    }

    // Vote for a candidate
    function vote(address candidate) external {
        require(votes[candidate] > 0 || isCandidate(candidate), "Not a valid candidate");
        require(votes[candidate] < type(uint8).max, "Max votes reached for candidate");

        // Increment votes
        votes[candidate]++;
    }

    // Get total votes for a candidate
    function getVotes(address candidate) external view returns (uint8) {
        return votes[candidate];
    }

    // Get all candidates (only for off-chain use)
    function getCandidates() external view returns (address[] memory) {
        return candidates;
    }

    // Helper function to check if an address is a candidate
    function isCandidate(address candidate) private view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i] == candidate) {
                return true;
            }
        }
        return false;
    }
}