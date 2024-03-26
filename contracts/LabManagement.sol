// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LessonManagement.sol";
import "./LabManagement.sol";
import "./ProjectManagement.sol";
import "./practiceManagement.sol";

contract LabManagement {
    struct Laboratory {
        uint id;            //same as the subject's id
        string name;
        PracticeManagement.Practice[] practices;
    }
}