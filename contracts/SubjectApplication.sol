// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LessonManagement.sol";
import "./LabManagement.sol";
import "./ProjectManagement.sol";
import "./StudentAccountManagement.sol";

contract SubjectManagement {
    address public Student;

    modifier onlyStudent() {
        require(msg.sender == Student, "Only student can perform this action");
        _;
    }

    constructor() {
        Student = msg.sender;
    }

    function applyToSubject() external onlyStudent{
        //Function for the students to apply to a subject
        //this adds the student to the requests of the Subject
    }

}