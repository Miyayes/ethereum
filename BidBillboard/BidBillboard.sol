pragma solidity ^0.4.10;

contract BidBillboard {

	//State variables
	uint public currentBid;
	string public currentPosterUrl;
	address public owner;
	
    	//Replace poster
	function newPoster(string posterUrl) payable {

		//Ensure that bid is higher than currentBid
		require(msg.value > currentBid);
		currentBid = msg.value;

		//Set current poster to input img URL
		currentPosterUrl = posterUrl;

		//Trigger event
		newPosterSuccess(msg.sender, this.balance);

	}

	//Event to watch on front-end to sync poster
	event newPosterSuccess(address buyer, uint balance);


	/* === HOUSEKEEPING FUNCTIONS === */


	//Constructor function	
	function BidBillboard() {

		//Set admin/owner to initial deployer
		owner = msg.sender;

	}

	//Modifier for admin/owner
	modifier OnlyOwner() {

		require(msg.sender == owner);
		_;

	}

	//Withdraw profits to
	function withdraw (uint amount, address to) OnlyOwner {

		//Ensure a valid withdrawal amount
		require(amount > 0);
		to.transfer(amount);

	}

	//Destroy contract and dump all ETH balances to input address
	function selfDestruct(address to) OnlyOwner {

		suicide(to);

	}

	//Fallback function (payable to accept donated ETH)
	function () payable {

	}

}
