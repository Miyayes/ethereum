pragma solidity ^0.4.10;

contract KingOfEther {

	//State variables
	uint public currentBid;
	address public currentKing;
	address owner;
	
    //New King
	function newKing() payable {

		//Ensure that bid is higher than currentBid
		require(msg.value > currentBid);

		//Payout to previous king
		currentKing.transfer(msg.value);

		//Set new king
		currentBid = msg.value;
		currentKing = msg.sender;

		//Log succession
		newKingSuccess(msg.sender, msg.value);

	}

	//Event to announce a new king to watchers
	event newKingSuccess(address buyer, uint amount);


	/* === HOUSEKEEPING FUNCTIONS === */


	//Constructor function	
	function KingOfEther() {

		//Set admin/owner to initial deployer
		owner = msg.sender;
		currentKing = msg.sender;

	}

	//Modifier for admin/owner
	modifier OnlyOwner() {

		require(msg.sender == owner);
		_;

	}

	//Destroy contract and dump all ETH to current king
	function selfDestruct() OnlyOwner {

		suicide(currentKing);

	}

	//Fallback function (payable to accept donated ETH)
	function () payable {

	}

}
