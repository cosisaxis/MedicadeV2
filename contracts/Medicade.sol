pragma solidity ^0.8.0;

contract Medicade {

    struct Record{
        string  name;
        uint age;
        string  condition;
        address owner;
    }

    //Record[] public records;
    mapping(address => Record) public records;

    function createMedRecord(string memory _name, uint _age, string memory _condition) public{
        require (_age >= 18, "You are not old enough");
        Record memory record;
        record.name = _name;
        record.age = _age;
        record.condition = _condition;
        record.owner = msg.sender;
        records[msg.sender]= record;
    }

    function getMedRecords(address _user) public view returns(string memory name, uint age, string memory condition){
       Record memory record = records[_user];
       return(record.name, record.age, record.condition);
    }

    function getCondition(address _user) external view returns(string memory){
       Record memory userRecords = records[_user];
       return userRecords.condition ;
   }
   
}