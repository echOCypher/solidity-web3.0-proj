// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract Greeting {
    string public name;
    string public age;
    string public greetingPrefix = "Hello ";

    constructor(string memory initialName, string memory initialAge) {
        name = initialName;
        age = initialAge;
    }

    function setName(string memory newName) public {
        name = newName;
    }
    function setAge(string memory newAge) public {
        age = newAge;
    }

    function getGreeting() public view returns(string memory) {
        return string(abi.encodePacked(greetingPrefix, name));
    }

    function getAge() public view returns(string memory) {
        return string(age);
    }
}
