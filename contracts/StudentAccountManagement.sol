// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentAccountManagement {
    address public director;
    uint256 public studentCount;
    mapping(string => bool) public usernameExists;
    mapping(uint256 => Student) public students;

    struct Student {
        uint256 id;
        string name;
        string surname;
        string username;
        string password;
        bool accountCreated;
        string[] subjects;  //When accepted in a subject, it will be added here.
    }

    event AccountCreated(address indexed student, string indexed username);

    modifier onlyDirector() {
        require(msg.sender == director, "Only the director can call this function");
        _;
    }

    constructor() {
        director = msg.sender;
    }

    function accountCreation(string memory _name, string memory _surname, string memory _password) external onlyDirector {
        studentCount++;
        string memory username = generateUsername(_name, _surname);
        students[studentCount] = Student(studentCount, _name, _surname, username, _password, true, new string[](0));
        usernameExists[username] = true;
        emit AccountCreated(msg.sender, username);
    }

    function generateUsername(string memory _name, string memory _surname) private view returns (string memory) {
        string memory username = string(abi.encodePacked(_name, ".", _surname));
        uint256 aux = 2;
        while (usernameExists[username]) {
            username = string(abi.encodePacked(username, toString(aux)));
            aux++;
        }
        return username;
    }

    function toString(uint value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits--;
            buffer[digits] = bytes1(uint8(48 + (value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
