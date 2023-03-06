pragma solidity ^0.8.0;

contract Medicade {

    struct Record{
        string  name;
        string gender;
        string  condition;
        uint age;
        address owner;
    }

    //Record[] public records;
    mapping(address => Record) public records;

    function createMedRecord(string memory _name, string memory _gender,  uint _age, string memory _condition) public{
        require (_age >= 18, "You are not old enough");
        Record memory record;
        record.name = _name;
        record.gender = _gender;
        record.age = _age;
        record.condition = _condition;
        record.owner = msg.sender;
        records[msg.sender]= record;
    }

    function getEntireMedRecords(address _user) public view returns(string memory name, uint age, string memory condition, string memory _gender){
       Record memory record = records[_user];
       return(record.name, record.age, record.condition, record.gender );
    }

    function getCondition(address _user) external view returns(string memory){
       Record memory userRecords = records[_user];
       return userRecords.condition ;
   }
   
}