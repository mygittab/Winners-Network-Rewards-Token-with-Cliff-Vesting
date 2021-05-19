// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WinsToken is ERC20, Ownable {
    event Mint(address indexed to, uint256 amount);
    event MintFinished();

    bool public mintingFinished = false;

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 _initialSupply
    ) ERC20(name_, symbol_) Ownable() {
        _mint(msg.sender, _initialSupply);
    }

    modifier canMint() {
        require(!mintingFinished, "ERC20: Minting is finished");
        _;
    }

    function mint(address _to, uint256 _amount) external onlyOwner canMint returns (bool) {
        _mint(_to, _amount);
        return true;
    }

    function finishMinting() external onlyOwner returns (bool) {
        mintingFinished = true;
        emit MintFinished();
        return true;
    }

    function burn(uint256 _amount) external onlyOwner returns (bool) {
        _burn(msg.sender, _amount);
        return true;
    }
}
