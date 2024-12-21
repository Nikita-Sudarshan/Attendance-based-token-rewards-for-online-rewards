// SPDX-License-Identifier: MIT



pragma solidity ^0.8.0;

contract AttendanceToken {
    string public name = "AttendanceToken";
    string public symbol = "ATKN";
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    mapping(address => mapping(uint256 => bool)) public attendance;

    event TokensIssued(address indexed student, uint256 amount);
    event AttendanceRecorded(address indexed student, uint256 classId);

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply;
    }

    function recordAttendance(address student, uint256 classId) public {
        require(!attendance[student][classId], "Attendance already recorded for this class.");
        attendance[student][classId] = true;
        uint256 rewardAmount = 10;
        balances[student] += rewardAmount;
        emit TokensIssued(student, rewardAmount);
        emit AttendanceRecorded(student, classId);
    }

    function getBalance(address student) public view returns (uint256) {
        return balances[student];
    }
}
