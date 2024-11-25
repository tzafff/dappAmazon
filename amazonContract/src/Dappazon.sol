// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract Dappazon {

    address public owner;
    
    error Dappazon__NotEnoughItemsAvailable();
    error Dappazon__InsufficientBalance();

    struct Item {
        uint256 id;
        address seller;
        string name;
        string category;
        string image;
        uint256 cost;
    }

    mapping(uint256 => Item) public items;
    mapping(uint256 => mapping(address => Item)) public ownership;

    uint256 public itemCount;
    address public erc20Token;

    event ItemListed(uint256 id, address seller, uint256 cost);
    event ItemPurchased(uint256 id, address buyer, uint256 stock);

    constructor(address _erc20Token) {
        owner = msg.sender;
        erc20Token = _erc20Token; // ERC-20 token to use for purchases
    }

    function listItem(string memory _name, string memory _category, string memory _image, uint256 _cost) external {
        require(_cost > 0, "Price must be greater than zero");

        itemCount++;
        Item memory item = Item({
            seller: msg.sender,
            id: itemCount,
            name: _name,
            category: _category,
            image: _image,
            cost: _cost
        });

        emit ItemListed(itemCount, msg.sender, _cost);

        items[itemCount] = item;

    }

    function buyItem(uint256 id, uint256 _quantity) external {
        Item storage item = items[id];
        
        if(item.cost * _quantity > IERC20(erc20Token).balanceOf(msg.sender)){
            revert Dappazon__InsufficientBalance();
            
        }
        // require(item.cost * _quantity <= IERC20(erc20Token).allowance(msg.sender, address(this)), "Insufficient allowance");

        ownership[id][msg.sender] = item;
        
        // Transfer ERC-20 tokens from buyer to seller
        IERC20(erc20Token).transferFrom(msg.sender, item.seller, item.cost * _quantity);

    

        emit ItemPurchased(id, msg.sender, _quantity);
    }
    
}