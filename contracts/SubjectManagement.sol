// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LessonManagement.sol";
import "./LabManagement.sol";
import "./ProjectManagement.sol";
import "./StudentAccountManagement.sol";

contract SubjectManagement {
    address public coordinator;
    uint256 public subjectsCount;
    StudentAccountManagement public studentsContract;

    struct Subject {
        uint256 idSubject;
        string name;
        uint256 ECTs;
        uint256 capacity;
        uint256 enrolled;
        string teacher;
        mapping(uint256 => StudentAccountManagement.Student) studentsRequests;
        mapping(uint256 => StudentAccountManagement.Student) studentsAccepted;
        //missing values settting
        string prerequisite; //subject that the student should pass before enrolling in current subject
        uint256 finalMark; 
        LessonManagement.Lesson lesson;     //every subject has these 3 parts.
        LaboratoryManagement.Laboratory lab;
        ProjectManagement.Project project;
    }

    mapping(uint256 => Subject) public subjects; //subjects of the faculty

    event StudentEnrolled(address indexed student, uint256 subjectId);
    event StudentAccepted(address indexed student, uint256 subjectId);

    modifier onlyCoordinator() {
        require(msg.sender == coordinator, "Only coordinator can perform this action");
        _;
    }
    
    constructor(address _studentsAddress) {
        coordinator = msg.sender;
        studentsContract = StudentAccountManagement(_studentsAddress);
        this.addSubject("Mathematics", 5, 50, "John Doe", "");
        this.addSubject("Physics", 4, 40, "Alice Smith", "Mathematics");
        this.addSubject("Physics 2", 4, 40, "Alice Smith", "Physics");
    }

    function addSubject(string memory _name, uint256 _ECTs, uint256 _capacity, string memory _teacher, string memory _prerequisite) external onlyCoordinator {
        //Subject storage newSubject = Subject(subjectsCount, _name, _ECTs, _capacity, 0, _teacher, _prerequisite, 0, LessonManagement.Lesson(0), LaboratoryManagement.Laboratory(0), ProjectManagement.Project(0));
        subjectsCount++;
       // subjects[subjectsCount] = newSubject;
        //fix this ffff function
    }

    function enrollStudent(uint256 _subjectId, uint256 _id) external onlyCoordinator {
        
        Subject storage subject = subjects[_subjectId];
        
        //next line has to add the student to the accepted students list of the subject. look for solutionnnnn
        subject.studentsAccepted[_id] = studentsContract.students[_subjectId];
        //the student is not anymore in the requests list
        delete subject.studentsRequests[_id];

        emit StudentAccepted(msg.sender, _subjectId);
    }

    
    // Add other functions as needed
}
