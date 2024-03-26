// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LessonManagement.sol";
import "./LabManagement.sol";
import "./ProjectManagement.sol";
import "./StudentAccountManagement.sol";

contract SubmissionManagement {
    address public teacher;
    uint256 public submissionsCount;

    struct Submission {
        string name;
        uint256 deadline; //look for info about managing time
        uint256 mark;
        string ipfsHash;    //FILE (is this ok?) 
    }

    mapping(uint256 => Submission) public submissions; 

    event taskCreated();
    event SubmissionReceived(uint256 indexed id, string ipfsHash);

    modifier onlyTeacher() {
        require(msg.sender == teacher, "Only teacher can perform this action");
        _;
    }

    constructor(){
        teacher = msg.sender;
    }

    function createTask(string memory _name, string memory _taskType, string memory _explanation, uint256 _deadline, bytes memory _document) external onlyTeacher {
        //function to create tasks (only teachers)
        require(_deadline > block.timestamp, "Deadline must be in the future");
        //FIX THISSSS
        submissions[msg.sender] = Submission(_name, _taskType, _explanation, _deadline, _document, 0);
        emit taskCreated();
        
    }

    function submit(uint256 _submissionId, string memory _ipfsHash) external {
        //students will submit the files with this function.
        //re-think how will this work
    }

    //FUNCTION TO CONVERT THE DATE TO UNIX MISSING

}