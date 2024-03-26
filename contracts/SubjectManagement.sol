// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LessonManagement.sol";
import "./LaboratoryManagement.sol";
import "./ProjectManagement.sol";

contract SubjectManagement {
    address public coordinator;
    uint256 public subjectsCount;

    struct Subject {
        uint256 id;
        string name;
        uint256 ECTs;
        uint256 capacity;
        uint256 enrolled;
        string teacher;
        mapping(address => bool) studentsRequests;
        mapping(address => bool) studentsAccepted;
        string prerequisite;
        uint256 finalMark;
        LessonManagement.Lesson lesson;
        LaboratoryManagement.Laboratory lab;
        ProjectManagement.Project project;
    }

    mapping(uint256 => Subject) public subjects;

    event StudentEnrolled(address indexed student, uint256 subjectId);
    event StudentAccepted(address indexed student, uint256 subjectId);

    modifier onlyCoordinator() {
        require(msg.sender == coordinator, "Only coordinator can perform this action");
        _;
    }

    constructor() {
        coordinator = msg.sender;

        // Create 10 example subjects
        for (uint256 i = 1; i <= 10; i++) {
            addSubject("Subject " + string(i), i * 5, 50, "Teacher " + string(i), "");
        }
    }

    function addSubject(string memory _name, uint256 _ECTs, uint256 _capacity, string memory _teacher, string memory _prerequisite) external onlyCoordinator {
    subjectsCount++;
    subjects[subjectsCount] = Subject(subjectsCount, _name, _ECTs, _capacity, 0, _teacher, "", "", _prerequisite, 0, LessonManagement.Lesson(0), LaboratoryManagement.Laboratory(0), ProjectManagement.Project(0));
    }

    function enrollStudent(uint256 _subjectId) external onlyCoordinator {
        Subject storage subject = subjects[_subjectId];
        require(subject.studentsRequests[msg.sender], "Student has not requested enrollment");

        // Add additional checks if needed
        
        // Move student from requests to accepted
        subject.studentsAccepted[msg.sender] = true;
        delete subject.studentsRequests[msg.sender];

        emit StudentAccepted(msg.sender, _subjectId);
    }

    // Add other functions as needed
}
