// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StudentAccountManagement.sol";

contract AdmissionSystem {
    address public director;
    uint256 public minimumGrade = 5;
    address public studentAccAddress; // Variable para almacenar la dirección del contrato StudentAccountManagement


    event MinimumGradeSet(uint256 minimumGrade);
    event StudentAccepted(address indexed student, uint256 grade);

    modifier onlyDirector() {
        require(msg.sender == director, "Only the director can call this function");
        _;
    }

    constructor() {
        director = msg.sender;
    }

    function setMinimumGrade(uint256 _minimumGrade) external onlyDirector {
        minimumGrade = _minimumGrade;
        emit MinimumGradeSet(_minimumGrade);
    }

    function acceptStudent(address _student, uint256 _grade) external onlyDirector {
    require(_grade >= minimumGrade, "Student's grade is below the minimum required");
    StudentAccountManagement studentAccountCreation = StudentAccountManagement(studentAccAddress);
    studentAccountCreation.accountCreation("Name", "Surname", "Password");
    emit StudentAccepted(_student, _grade);
    }

    //Still  have to think how to manage students requests.
}
