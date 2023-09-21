// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction{
    struct item{
        uint id;
        string name;
        string description;
        address payable highestBidder;
        uint highestbid;
    }
    mapping(uint => item) public items;
    uint public itemCount;

    constructor() {
        itemCount=0;
    }

    function addItems(uint _id, string memory _name, string memory _description) public {
        itemCount++;
        items[itemCount]= item(_id, _name, _description, payable(msg.sender), 0);
    } 

    function placeBid(uint _Id, uint _amount) public {
        require(_Id > 0 && _Id <= itemCount, "Invalid ID");
        require(_amount > items[_Id].highestbid, "Bid amount must be higher than current highest bid");

        if (items[_Id].highestBidder != address(0)) {
            items[_Id].highestBidder.transfer(items[_Id].highestbid);
        }
        items[_Id].highestBidder = payable(msg.sender);
        items[_Id].highestbid = _amount;
    }

    function WinningBid(uint _Id) public view returns (address, uint) {
        require(_Id > 0 && _Id <= itemCount, "Invalid item ID");
        return (items[_Id].highestBidder, items[_Id].highestbid);
    }
}