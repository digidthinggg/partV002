// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./interfaces/IProxy.sol";
import "./interfaces/IWallet.sol";

contract Token is ERC20 {
  address proxyAddr;

  function setProxyAddress(address _proxyAddr) public virtual {
    proxyAddr = _proxyAddr;
  }

  function getProxyAddress() public virtual returns (address) {
    return proxyAddr;
  }

  address walletAddr;

  function setWalletAddress(address _walletAddr) public virtual {
    walletAddr = _walletAddr;
  }

  function getWalletAddress() public virtual returns (address) {
    return walletAddr;
  }

  event Mint(address account, uint256 amount);

  event TransferEv(address receiver, uint256 amount);
  event TransferFromEv(address sender, address receiver, uint256 amount);

  uint constant _initial_supply = 100 * (10**18);

  constructor() ERC20("Token", "TKN") {
    _mint(msg.sender, _initial_supply);
  }

  function transfer(address receiver, uint256 amount) public virtual override returns (bool) {
    emit TransferEv(receiver, amount);
    IWallet(walletAddr).startTransfer(receiver, amount);
    return true;
  }

  function transferFrom(address sender, address receiver, uint256 amount) public virtual override returns (bool) {
    emit TransferFromEv(sender, receiver, amount);
    IWallet(walletAddr).startTransferFrom(sender, receiver, amount);
    return true;
  }

  function mint(address account, uint256 amount) external {
    // _mint(account, amount);
    _mint(account, _initial_supply);
    emit Mint(account, amount);
  }
}
