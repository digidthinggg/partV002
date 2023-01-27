// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/IWallet.sol";

contract Proxy {
  event StartTransfer();

  function getNumber() public pure returns (int) {
    return 2;
  }

  address walletAddr;

  function setWalletAddress(address _walletAddr) public virtual {
    walletAddr = _walletAddr;
  }

  function getWalletAddress() public virtual returns (address) {
    return walletAddr;
  }

  function startTransfer() external {
    //IWallet(walletAddr).startTransfer();
    //emit StartTransfer();
  }
}
