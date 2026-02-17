// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @title ShepardComplianceWrapper (wSHEPARD)
/// @notice ERC-3643 Compliant Wrapper for $SHEPARD on Metal L2
/// @dev Deployed at 0x4d68CD64F450dA96A938fb9a85E86Ba9fE7d8Dc9
/// Wraps raw $SHEPARD (0x74EA40E2E07806Cef2Fe129bB70d44c9C20F76C5) into compliant wSHEPARD
/// Authority: 48 Stat. 112; UCC Arts. 3, 7, 9, 12
contract ShepardComplianceWrapper is ERC20, Ownable, ReentrancyGuard {

    IERC20 public immutable underlyingToken;
    mapping(address => bool) public isWhitelisted;

    event WhitelistUpdated(address indexed user, bool status);
    event Wrapped(address indexed user, uint256 amount);
    event Unwrapped(address indexed user, uint256 amount);

    constructor(address _underlyingToken)
        ERC20("Shepard Compliant Note", "wSHEPARD")
        Ownable(msg.sender)
    {
        underlyingToken = IERC20(_underlyingToken);
        isWhitelisted[msg.sender] = true;
    }

    function wrap(uint256 amount) external nonReentrant {
        require(isWhitelisted[msg.sender], "Not Whitelisted");
        require(underlyingToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        _mint(msg.sender, amount);
        emit Wrapped(msg.sender, amount);
    }

    function unwrap(uint256 amount) external onlyOwner nonReentrant {
        require(balanceOf(msg.sender) >= amount, "Insufficient wSHEPARD");
        _burn(msg.sender, amount);
        require(underlyingToken.transfer(msg.sender, amount), "Transfer failed");
        emit Unwrapped(msg.sender, amount);
    }

    function _update(address from, address to, uint256 value) internal override {
        if (from == address(0)) {
            // Minting - sender must be whitelisted (checked in wrap())
        } else if (to == address(0)) {
            // Burning - sender must be whitelisted
            require(isWhitelisted[from], "Not Whitelisted");
        } else {
            // Transfer - both must be whitelisted
            require(isWhitelisted[from], "Not Whitelisted");
            require(isWhitelisted[to], "Not Whitelisted");
        }
        super._update(from, to, value);
    }

    function updateWhitelist(address _user, bool _status) external onlyOwner {
        isWhitelisted[_user] = _status;
        emit WhitelistUpdated(_user, _status);
    }

    function rescueTokens(address _tokenAddr, uint256 _amount) external onlyOwner {
        require(_tokenAddr != address(underlyingToken), "Cannot rescue collateral!");
        (bool success, ) = _tokenAddr.call(abi.encodeWithSignature("transfer(address,uint256)", msg.sender, _amount));
        require(success, "Rescue failed");
    }
}
